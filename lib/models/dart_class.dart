import 'dart_field.dart';

class DartClass {
  final String name;
  final List<DartField> fields = [];
  final List<DartClass> children = [];

  DartClass(this.name);

  @override
  String toString() {
    return '''
Class: $name

Fields:
${fields.map((e) => ' - ${e.type} ${e.dartName}').join('\n')}
''';
  }
}