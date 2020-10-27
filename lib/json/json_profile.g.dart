// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonProfile _$JsonProfileFromJson(Map<String, dynamic> json) {
  return JsonProfile(
    origin: json['origin'] as String,
    target: json['target'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$JsonProfileToJson(JsonProfile instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'target': instance.target,
      'url': instance.url,
    };
