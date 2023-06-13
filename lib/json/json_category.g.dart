// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonCategory _$JsonCategoryFromJson(Map<String, dynamic> json) => JsonCategory(
      name: json['name'] as String? ?? '',
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => JsonEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$JsonCategoryToJson(JsonCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
    };
