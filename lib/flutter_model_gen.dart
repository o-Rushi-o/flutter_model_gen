// library rest_model_generator;

import 'generator/model_generator.dart';

class FlutterModelGenerator {
  Future<void> run(List<String> args) async {
    final generator = ModelGenerator();

    await generator.generate(args);
  }
}
