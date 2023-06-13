import 'package:json_annotation/json_annotation.dart';
import 'package:languages/json/json_entry.dart';

part 'json_category.g.dart';

@JsonSerializable()
class JsonCategory {
  final String name;
  final List<JsonEntry> values;

  const JsonCategory({
    this.name = '',
    this.values = const [],
  });

  factory JsonCategory.fromJson(Map<String, dynamic> json) =>
      _$JsonCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$JsonCategoryToJson(this);

  static List<JsonCategory> fromJsonList(List<dynamic> json) =>
      // ignore: unnecessary_lambdas
      json.map((e) => _$JsonCategoryFromJson(e)).toList();
}
