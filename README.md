# Flutter Model Gen

A Dart CLI tool that automatically generates **Flutter/Dart models from API responses**.

Simply provide an API URL and `flutter_model_gen` fetches the response, analyzes the JSON structure, detects data types and nested objects, and generates clean Dart model classes with null safety, `fromJson()` and `toJson()` support.

## ✨ Features

* 🚀 Generate models directly from an API URL
* 🔍 Automatically detect JSON data types
* 🧩 Generate nested models
* 📄 Generate all models in a single Dart file
* 🐍 Convert API field names to Dart `camelCase`
* 🛡️ Null-safe model generation
* 🔄 Automatically merge fields from multiple objects
* 📥 Generate `fromJson()`
* 📤 Generate `toJson()`
* 🔢 Support `String`, `int`, `double`, `bool`
* 🏗️ Generate nested object models
* ⚡ Simple CLI commands

## 📦 Installation

Activate the package globally:

```bash
dart pub global activate flutter_model_gen
```

Or add it as a development dependency:

```bash
dart pub add --dev flutter_model_gen
```

## 🚀 Usage

Provide an API endpoint using the `--url` option:

```bash
dart run flutter_model_gen --url https://api.restful-api.dev/objects
```

The generator will:

1. Call the API.
2. Read the JSON response.
3. Analyze the response structure.
4. Detect primitive and nested types.
5. Merge fields from multiple objects.
6. Convert JSON field names to Dart `camelCase`.
7. Generate the Dart model.
8. Add `fromJson()`.
9. Add `toJson()`.

Generated files are currently written to:

```text
lib/models/
```

Example:

```text
lib/
└── models/
    └── product.dart
```

## 🧪 Example API Response

Given an API response like:

```json
[
  {
    "id": "1",
    "name": "Google Pixel 6 Pro",
    "data": {
      "color": "Cloudy White",
      "capacity": "128 GB"
    }
  },
  {
    "id": "2",
    "name": "Apple iPhone 12 Mini, 256GB, Blue",
    "data": null
  },
  {
    "id": "3",
    "name": "Apple iPhone 12 Pro Max",
    "data": {
      "color": "Cloudy White",
      "capacity GB": 512
    }
  }
]
```

The generator produces:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

class Product {
  final String? id;
  final String? name;
  final ProductData? data;

  Product({
    this.id,
    this.name,
    this.data,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String?,
      name: json['name'] as String?,
      data: json['data'] == null
          ? null
          : ProductData.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'data': data?.toJson(),
    };
  }
}

class ProductData {
  final String? color;
  final String? capacity;
  final int? capacityGb;

  ProductData({
    this.color,
    this.capacity,
    this.capacityGb,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      color: json['color'] as String?,
      capacity: json['capacity'] as String?,
      capacityGb: json['capacity GB'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'capacity': capacity,
      'capacity GB': capacityGb,
    };
  }
}
```

## 🐫 CamelCase Conversion

API keys are preserved for JSON serialization while Dart variable names are converted to `camelCase`.

For example:

| API Key          | Dart Variable  |
| ---------------- | -------------- |
| `first_name`     | `firstName`    |
| `first-name`     | `firstName`    |
| `CPU model`      | `cpuModel`     |
| `Hard disk size` | `hardDiskSize` |
| `capacity GB`    | `capacityGb`   |
| `Screen size`    | `screenSize`   |

The original API key is always preserved for `fromJson()` and `toJson()`.

Example:

```dart
final String? cpuModel;
```

maps to:

```dart
json['CPU model']
```

and:

```dart
'CPU model': cpuModel
```

## 🛡️ Null Safety

The generator is designed to create defensive, null-safe models.

Generated fields are nullable:

```dart
final String? name;
final int? age;
final double? price;
final UserData? data;
```

This helps protect applications from APIs returning:

```json
{
  "name": null
}
```

or:

```json
{
  "name": "John"
}
```

or completely omitting a field.

## 🔢 Type Detection

The generator automatically detects common JSON types.

### String

```json
{
  "name": "John"
}
```

Generates:

```dart
final String? name;
```

### Integer

```json
{
  "age": 25
}
```

Generates:

```dart
final int? age;
```

### Double

```json
{
  "price": 99.99
}
```

Generates:

```dart
final double? price;
```

### Boolean

```json
{
  "active": true
}
```

Generates:

```dart
final bool? active;
```

### Nested Object

```json
{
  "user": {
    "name": "John"
  }
}
```

Generates:

```dart
final User? user;
```

and:

```dart
class User {
  final String? name;
}
```

## 🔄 JSON Serialization

Every generated model contains both:

### `fromJson()`

```dart
final product = Product.fromJson(json);
```

### `toJson()`

```dart
final json = product.toJson();
```

Nested objects are automatically handled:

```dart
data: json['data'] == null
    ? null
    : ProductData.fromJson(
        json['data'] as Map<String, dynamic>,
      ),
```

and:

```dart
'data': data?.toJson(),
```

## 📁 Generated File Structure

The current generator creates a single model file:

```text
lib/
└── models/
    └── product.dart
```

Nested classes are kept in the same file, so no additional model imports are required.

Example:

```dart
class Product {
  ...
}

class ProductData {
  ...
}
```

## 🧠 Schema Merging

When an API returns multiple objects with different fields, the generator combines the available fields into a single model.

For example:

```json
[
  {
    "id": 1,
    "data": {
      "color": "White"
    }
  },
  {
    "id": 2,
    "data": {
      "price": 599.99
    }
  }
]
```

The generated model understands both fields:

```dart
class ProductData {
  final String? color;
  final double? price;
}
```

This makes the generator useful for APIs where different objects contain different properties.

## 🖥️ CLI Options

### API URL

```bash
--url <url>
```

Example:

```bash
dart run flutter_model_gen \
  --url https://api.example.com/users
```

### Current command format

```bash
dart run flutter_model_gen --url <API_URL>
```

## 🚧 Roadmap

The project is actively being developed.

Planned features include:

* [ ] GET / POST / PUT / PATCH / DELETE API support
* [ ] Request body support
* [ ] Custom HTTP headers
* [ ] Query parameters
* [ ] List of objects
* [ ] List of primitive values
* [ ] Mixed/dynamic lists
* [ ] Root-level list handling improvements
* [ ] DateTime detection
* [ ] Enum generation
* [ ] `copyWith()`
* [ ] `==` and `hashCode`
* [ ] `toString()`
* [ ] Custom output directory
* [ ] Custom model/class names
* [ ] Config file support
* [ ] Custom naming strategies
* [ ] `json_serializable` support
* [ ] Freezed model generation
* [ ] Authentication support
* [ ] Better CLI argument parsing
* [ ] Unit tests
* [ ] More robust API/schema inference

## 🤝 Contributing

Contributions are welcome.

If you find a bug, have a feature request, or want to improve the generator, please open an issue or submit a pull request.

Before submitting a pull request, make sure the project builds successfully and existing tests continue to pass.

## 📄 License

This project is licensed under the MIT License.

See the `LICENSE` file for details.

## ⭐ Support

If you find `flutter_model_gen` useful, consider giving the project a ⭐ and sharing it with other Flutter developers.

---

Built for Flutter developers who are tired of manually writing API models. 🚀
