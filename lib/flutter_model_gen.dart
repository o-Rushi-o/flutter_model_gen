// library flutter_model_gen;

import 'generator/model_generator.dart';

class FlutterModelGenerator {
  Future<void> run(List<String> args) async {
    final generator = ModelGenerator();

    await generator.generate(args);
  }
}
