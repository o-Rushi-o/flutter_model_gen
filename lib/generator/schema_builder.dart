import 'package:rest_model_generator/utils/string_utils.dart';

import '../models/dart_class.dart';
import '../models/dart_field.dart';

class SchemaBuilder {
  DartClass buildFromList({
    required String className,
    required List<dynamic> jsonList,
  }) {
    final model = DartClass(className);

    for (final item in jsonList) {
      if (item is Map<String, dynamic>) {
        _merge(model, item);
      }
    }

    return model;
  }

  DartClass buildFromMap({
    required String className,
    required Map<String, dynamic> json,
  }) {
    final model = DartClass(className);

    _merge(model, json);

    return model;
  }

  void _merge(DartClass model, Map<String, dynamic> json) {
    json.forEach((key, value) {
      final existing = model.fields.where((e) => e.jsonKey == key);

      if (existing.isEmpty) {
        _addField(model, key, value);
      } else {
        _updateField(model, existing.first, value);
      }
    });
  }

  void _addField(DartClass model, String key, dynamic value) {
    final dartName = StringUtils.toCamelCase(key);

    // Prevent duplicate Dart variable names.
    if (model.fields.any((f) => f.dartName == dartName)) {
      return;
    }

    // -------------------------
    // NULL
    // -------------------------

    if (value == null) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "dynamic",
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // STRING
    // -------------------------

    if (value is String) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "String",
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // INT
    // -------------------------

    if (value is int) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "int",
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // DOUBLE
    // -------------------------

    if (value is double) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "double",
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // BOOL
    // -------------------------

    if (value is bool) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "bool",
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // MAP / OBJECT
    // -------------------------

    if (value is Map<String, dynamic>) {
      final child = DartClass("${model.name}${StringUtils.toPascalCase(key)}");

      _merge(child, value);

      model.children.add(child);

      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: child.name,
          isObject: true,
          isPrimitive: false,
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // LIST
    // -------------------------

    if (value is List) {
      _addListField(model: model, key: key, value: value);

      return;
    }
  }

  void _addListField({
    required DartClass model,
    required String key,
    required List value,
  }) {
    final dartName = StringUtils.toCamelCase(key);

    // Empty list -> dynamic list
    if (value.isEmpty) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "dynamic",
          isList: true,
          nullable: true,
        ),
      );

      return;
    }

    final first = value.first;

    // -------------------------
    // LIST OF OBJECTS
    // -------------------------

    if (first is Map<String, dynamic>) {
      final childName = StringUtils.toPascalCase(_singularize(dartName));

      final child = DartClass(childName);

      // Merge every object in the list.
      for (final item in value) {
        if (item is Map<String, dynamic>) {
          _merge(child, item);
        }
      }

      model.children.add(child);

      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: child.name,
          isList: true,
          isObject: true,
          isPrimitive: false,
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // LIST OF STRINGS
    // -------------------------

    if (first is String) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "String",
          isList: true,
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // LIST OF INTS
    // -------------------------

    if (first is int) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "int",
          isList: true,
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // LIST OF DOUBLES
    // -------------------------

    if (first is double) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "double",
          isList: true,
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // LIST OF BOOLEANS
    // -------------------------

    if (first is bool) {
      model.fields.add(
        DartField(
          jsonKey: key,
          dartName: dartName,
          type: "bool",
          isList: true,
          nullable: true,
        ),
      );

      return;
    }

    // -------------------------
    // MIXED LIST
    // -------------------------

    model.fields.add(
      DartField(
        jsonKey: key,
        dartName: dartName,
        type: "dynamic",
        isList: true,
        nullable: true,
      ),
    );
  }

  void _updateField(DartClass model, DartField field, dynamic value) {
    // -------------------------
    // NULL
    // -------------------------

    if (value == null) {
      _replaceField(model, field, nullable: true);

      return;
    }

    // -------------------------
    // OBJECT
    // -------------------------

    if (field.isObject && !field.isList && value is Map<String, dynamic>) {
      final child = model.children.firstWhere((e) => e.name == field.type);

      _merge(child, value);

      return;
    }

    // -------------------------
    // LIST OF OBJECTS
    // -------------------------

    if (field.isList && field.isObject && value is List) {
      final child = model.children.firstWhere((e) => e.name == field.type);

      for (final item in value) {
        if (item is Map<String, dynamic>) {
          _merge(child, item);
        }
      }

      return;
    }

    // -------------------------
    // TYPE CHANGED
    // -------------------------

    final newType = _getType(value);

    if (newType != null && newType != field.type) {
      _replaceField(
        model,
        field,
        type: newType,
        nullable: true,
        isList: false,
        isObject: false,
        isPrimitive: true,
      );
    }
  }

  String? _getType(dynamic value) {
    if (value is String) return "String";
    if (value is int) return "int";
    if (value is double) return "double";
    if (value is bool) return "bool";

    return null;
  }

  void _replaceField(
    DartClass model,
    DartField field, {
    String? type,
    bool? nullable,
    bool? isList,
    bool? isObject,
    bool? isPrimitive,
  }) {
    final index = model.fields.indexOf(field);

    if (index == -1) return;

    model.fields[index] = DartField(
      jsonKey: field.jsonKey,
      dartName: field.dartName,
      type: type ?? field.type,
      nullable: nullable ?? field.nullable,
      isList: isList ?? field.isList,
      isObject: isObject ?? field.isObject,
      isPrimitive: isPrimitive ?? field.isPrimitive,
    );
  }

  String _singularize(String value) {
    if (value.endsWith("ies")) {
      return "${value.substring(0, value.length - 3)}y";
    }

    if (value.endsWith("ses")) {
      return value.substring(0, value.length - 2);
    }

    if (value.endsWith("s") && !value.endsWith("ss")) {
      return value.substring(0, value.length - 1);
    }

    return value;
  }
}
