import 'package:json_annotation/json_annotation.dart';

part 'json_profile.g.dart';

@JsonSerializable()
class JsonProfile {
  final String origin;
  final String target;
  final String url;

  const JsonProfile({
    this.origin = '',
    this.target = '',
    this.url = '',
  });

  factory JsonProfile.fromJson(Map<String, dynamic> json) =>
      _$JsonProfileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonProfileToJson(this);
}
