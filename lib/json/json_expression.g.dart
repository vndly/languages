// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_expression.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonExpression _$JsonExpressionFromJson(Map<String, dynamic> json) =>
    JsonExpression(
      category: json['category'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      target: json['target'] as String? ?? '',
    );

Map<String, dynamic> _$JsonExpressionToJson(JsonExpression instance) =>
    <String, dynamic>{
      'category': instance.category,
      'origin': instance.origin,
      'target': instance.target,
    };
