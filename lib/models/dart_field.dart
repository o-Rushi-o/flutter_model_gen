class DartField {
  final String jsonKey; // Original JSON key (e.g. "CPU model")
  final String dartName; // Dart field name (e.g. cpuModel)
  final String type; // String, int, ProductData, etc.

  final bool nullable;
  final bool isList;
  final bool isObject;
  final bool isPrimitive;

  const DartField({
    required this.jsonKey,
    required this.dartName,
    required this.type,
    this.nullable = false,
    this.isList = false,
    this.isObject = false,
    this.isPrimitive = true,
  });

  String get declarationType {
    return "$type${nullable ? "?" : ""}";
  }

  @override
  String toString() {
    return "$declarationType $dartName";
  }
}
