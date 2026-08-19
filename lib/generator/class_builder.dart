import 'package:flutter_model_gen/models/dart_field.dart';

import '../models/dart_class.dart';

class ClassBuilder {
  String buildFile(DartClass root) {
    final buffer = StringBuffer();

    buffer.writeln("// GENERATED CODE - DO NOT MODIFY BY HAND");
    buffer.writeln();

    _buildClass(root, buffer);

    return buffer.toString();
  }

  void _buildClass(DartClass model, StringBuffer buffer) {
    buffer.writeln("class ${model.name} {");
    buffer.writeln();

    _buildFields(model, buffer);

    buffer.writeln();

    _buildConstructor(model, buffer);

    buffer.writeln();

    _buildFromJson(model, buffer);

    buffer.writeln();

    _buildToJson(model, buffer);

    buffer.writeln("}");
    buffer.writeln();

    for (final child in model.children) {
      _buildClass(child, buffer);
    }
  }

  // ----------------------------------------------------------
  // FIELDS
  // ----------------------------------------------------------

  void _buildFields(DartClass model, StringBuffer buffer) {
    for (final field in model.fields) {
      final type = _fieldDeclarationType(field);

      buffer.writeln("  final $type ${field.dartName};");
    }
  }

  String _fieldDeclarationType(DartField field) {
    if (field.isList) {
      return "List<${field.type}>${field.nullable ? '?' : ''}";
    }

    return "${field.type}${field.nullable ? '?' : ''}";
  }

  // ----------------------------------------------------------
  // CONSTRUCTOR
  // ----------------------------------------------------------

  void _buildConstructor(DartClass model, StringBuffer buffer) {
    buffer.writeln("  ${model.name}({");

    for (final field in model.fields) {
      if (field.nullable) {
        buffer.writeln("    this.${field.dartName},");
      } else {
        buffer.writeln("    required this.${field.dartName},");
      }
    }

    buffer.writeln("  });");
  }

  // ----------------------------------------------------------
  // FROM JSON
  // ----------------------------------------------------------

  void _buildFromJson(DartClass model, StringBuffer buffer) {
    buffer.writeln();

    buffer.writeln(
      "  factory ${model.name}.fromJson("
      "Map<String, dynamic> json) {",
    );

    buffer.writeln("    return ${model.name}(");

    for (final field in model.fields) {
      buffer.writeln(
        "      ${field.dartName}: "
        "${_fromJsonValue(field)},",
      );
    }

    buffer.writeln("    );");
    buffer.writeln("  }");
  }

  String _fromJsonValue(DartField field) {
    // --------------------------------------------------------
    // LIST
    // --------------------------------------------------------

    if (field.isList) {
      // List of nested objects
      if (field.isObject) {
        return '''
(json['${field.jsonKey}'] as List?)
          ?.map(
            (e) => ${field.type}.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList()
''';
      }

      // List<dynamic>
      if (field.type == 'dynamic') {
        return "json['${field.jsonKey}'] as List?";
      }

      // List<String>, List<int>, List<double>, List<bool>
      return '''
(json['${field.jsonKey}'] as List?)
          ?.map(
            (e) => e as ${field.type},
          )
          .toList()
''';
    }

    // --------------------------------------------------------
    // NESTED OBJECT
    // --------------------------------------------------------

    if (field.isObject) {
      return '''
json['${field.jsonKey}'] == null
          ? null
          : ${field.type}.fromJson(
              json['${field.jsonKey}'] as Map<String, dynamic>,
            )
''';
    }

    // --------------------------------------------------------
    // PRIMITIVES
    // --------------------------------------------------------

    switch (field.type) {
      case 'double':
        return "(json['${field.jsonKey}'] as num?)?.toDouble()";

      case 'int':
        return "json['${field.jsonKey}'] as int?";

      case 'bool':
        return "json['${field.jsonKey}'] as bool?";

      case 'String':
        return "json['${field.jsonKey}'] as String?";

      default:
        return "json['${field.jsonKey}']";
    }
  }

  // ----------------------------------------------------------
  // TO JSON
  // ----------------------------------------------------------

  void _buildToJson(DartClass model, StringBuffer buffer) {
    buffer.writeln("  Map<String, dynamic> toJson() {");

    buffer.writeln("    return {");

    for (final field in model.fields) {
      buffer.writeln(
        "      '${field.jsonKey}': "
        "${_toJsonValue(field)},",
      );
    }

    buffer.writeln("    };");
    buffer.writeln("  }");
  }

  String _toJsonValue(DartField field) {
    // --------------------------------------------------------
    // LIST OF OBJECTS
    // --------------------------------------------------------

    if (field.isList && field.isObject) {
      return "${field.dartName}"
          "?.map((e) => e.toJson()).toList()";
    }

    // --------------------------------------------------------
    // LIST OF PRIMITIVES
    // --------------------------------------------------------

    if (field.isList) {
      return field.dartName;
    }

    // --------------------------------------------------------
    // NESTED OBJECT
    // --------------------------------------------------------

    if (field.isObject) {
      return "${field.dartName}?.toJson()";
    }

    // --------------------------------------------------------
    // PRIMITIVES
    // --------------------------------------------------------

    return field.dartName;
  }
}
