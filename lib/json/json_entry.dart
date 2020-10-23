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

  bool matches(String text) =>
      origin.toLowerCase().contains(text.toLowerCase()) ||
      target.toLowerCase().contains(text.toLowerCase());

  factory JsonEntry.fromJson(Map<String, dynamic> json) =>
      _$JsonEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEntryToJson(this);
}
