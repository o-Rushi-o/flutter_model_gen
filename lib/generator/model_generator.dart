import 'package:flutter_model_gen/generator/class_builder.dart';
import 'package:flutter_model_gen/generator/file_writer.dart';
import 'package:flutter_model_gen/generator/schema_builder.dart';
import 'package:flutter_model_gen/models/dart_class.dart';
import 'package:flutter_model_gen/utils/name_utils.dart';

import '../network/api_client.dart';

class ModelGenerator {
  final ApiClient _client = ApiClient();

  Future<void> generate(List<String> args) async {
    print("Flutter Model Generator");
    print("------------------------");

    final url = _readUrl(args);

    if (url == null) {
      throw Exception("Missing --url");
    }

    final json = await _client.get(url);

    final schema = SchemaBuilder();

    // ---------------------------------------------
    // Generate model name from URL
    // ---------------------------------------------

    final className = NameUtils.classNameFromUrl(url);

    final fileName = NameUtils.fileNameFromClassName(className);

    print("Model: $className");
    print("File: $fileName.dart");

    // ---------------------------------------------
    // Build schema
    // ---------------------------------------------

    DartClass root;

    if (json is List) {
      root = schema.buildFromList(
        className:
            "$className"
            "ApiResponse",
        jsonList: json,
      );
    } else if (json is Map<String, dynamic>) {
      root = schema.buildFromMap(
        className:
            "$className"
            "ApiResponse",
        json: json,
      );
    } else {
      throw Exception(
        "Unsupported API response type: "
        "${json.runtimeType}",
      );
    }

    // ---------------------------------------------
    // Generate Dart code
    // ---------------------------------------------

    final builder = ClassBuilder();

    final writer = FileWriter();

    await writer.write(
      directory: "lib/models",
      fileName:
          "$fileName"
          "ApiResponse.dart",
      content: builder.buildFile(root),
    );

    print(
      "✔ Generated: lib/models/$fileName"
      "ApiResponse.dart",
    );

    print("Done!");
  }

  String? _readUrl(List<String> args) {
    final index = args.indexOf("--url");

    if (index == -1) {
      return null;
    }

    if (index + 1 >= args.length) {
      return null;
    }

    return args[index + 1];
  }
}
