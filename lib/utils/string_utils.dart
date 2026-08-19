class StringUtils {
  static String toCamelCase(String text) {
    if (text.isEmpty) return text;

    // Split on anything that is not a letter or digit
    final words = text
        .split(RegExp(r'[^A-Za-z0-9]+'))
        .where((e) => e.isNotEmpty)
        .toList();

    if (words.isEmpty) return '';

    final buffer = StringBuffer();

    for (int i = 0; i < words.length; i++) {
      var word = words[i];

      if (i == 0) {
        buffer.write(
          word.substring(0, 1).toLowerCase() +
              word.substring(1),
        );
      } else {
        buffer.write(
          word.substring(0, 1).toUpperCase() +
              word.substring(1).toLowerCase(),
        );
      }
    }

    return buffer.toString();
  }

  static String toPascalCase(String text) {
    final camel = toCamelCase(text);

    if (camel.isEmpty) return '';

    return camel.substring(0, 1).toUpperCase() +
        camel.substring(1);
  }
}