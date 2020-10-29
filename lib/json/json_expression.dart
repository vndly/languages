import 'package:json_annotation/json_annotation.dart';

part 'json_expression.g.dart';

@JsonSerializable()
class JsonExpression {
  final String category;
  final String origin;
  final String target;

  const JsonExpression({
    this.category = '',
    this.origin = '',
    this.target = '',
  });

  bool get isNotEmpty => origin.isNotEmpty && target.isNotEmpty;

  bool matches(String text) =>
      origin.toLowerCase().contains(text.toLowerCase()) ||
      target.toLowerCase().contains(text.toLowerCase());

  factory JsonExpression.fromJson(Map<String, dynamic> json) =>
      _$JsonExpressionFromJson(json);

  Map<String, dynamic> toJson() => _$JsonExpressionToJson(this);

  static List<JsonExpression> fromJsonList(List<dynamic> json) =>
      json.map((e) => _$JsonExpressionFromJson(e)).toList();
}
