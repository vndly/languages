import 'package:json_annotation/json_annotation.dart';

part 'json_entry.g.dart';

@JsonSerializable()
class JsonEntry {
  final String origin;
  final String target;

  const JsonEntry({
    this.origin = '',
    this.target = '',
  });

  factory JsonEntry.fromJson(Map<String, dynamic> json) =>
      _$JsonEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEntryToJson(this);
}
