class NameUtils {
  static String classNameFromUrl(String url) {
    final uri = Uri.tryParse(url);

    if (uri == null) {
      return "Model";
    }

    final segments = uri.pathSegments
        .where((segment) => segment.isNotEmpty)
        .toList();

    if (segments.isEmpty) {
      return "Model";
    }

    // Find the last meaningful resource.
    //
    // /users
    // /users/1
    // /users/123/posts
    //
    // We want:
    // users
    // users
    // posts

    String resource;

    final last = segments.last;

    if (_isId(last)) {
      if (segments.length < 2) {
        return "Model";
      }

      resource = segments[segments.length - 2];
    } else {
      resource = last;
    }

    resource = _removeQueryOrExtension(resource);

    resource = _singularize(resource);

    return _toPascalCase(resource);
  }

  static String fileNameFromClassName(String className) {
    return _toSnakeCase(className);
  }

  static bool _isId(String value) {
    // Numeric ID
    if (int.tryParse(value) != null) {
      return true;
    }

    // UUID-like IDs
    final uuidRegex = RegExp(
      r'^[0-9a-fA-F]{8}-'
      r'[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{12}$',
    );

    return uuidRegex.hasMatch(value);
  }

  static String _removeQueryOrExtension(String value) {
    var result = value;

    if (result.contains('.')) {
      result = result.split('.').first;
    }

    return result;
  }

  static String _singularize(String value) {
    final lower = value.toLowerCase();

    if (lower.endsWith("ies")) {
      return "${value.substring(0, value.length - 3)}y";
    }

    if (lower.endsWith("ses")) {
      return value.substring(0, value.length - 2);
    }

    if (lower.endsWith("xes")) {
      return value.substring(0, value.length - 2);
    }

    if (lower.endsWith("zes")) {
      return value.substring(0, value.length - 2);
    }

    if (lower.endsWith("ches")) {
      return value.substring(0, value.length - 2);
    }

    if (lower.endsWith("shes")) {
      return value.substring(0, value.length - 2);
    }

    if (lower.endsWith("s") &&
        !lower.endsWith("ss")) {
      return value.substring(0, value.length - 1);
    }

    return value;
  }

  static String _toPascalCase(String value) {
    final parts = value
        .split(RegExp(r'[_\-\s]+'))
        .where((e) => e.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return "Model";
    }

    return parts.map((part) {
      return part[0].toUpperCase() +
          part.substring(1);
    }).join();
  }

  static String _toSnakeCase(String value) {
    final result = value
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (match) =>
              '${match.group(1)}_${match.group(2)}',
        )
        .replaceAll(
          RegExp(r'[\s\-]+'),
          '_',
        )
        .toLowerCase();

    return result;
  }
}