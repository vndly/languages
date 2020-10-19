import 'package:json_annotation/json_annotation.dart';

part 'json_entry.g.dart';

@JsonSerializable()
class JsonEntry {
  final String es;
  final String fr;

  const JsonEntry({
    this.es = '',
    this.fr = '',
  });

  bool matches(String text) =>
      es.toLowerCase().contains(text.toLowerCase()) ||
      fr.toLowerCase().contains(text.toLowerCase());

  factory JsonEntry.fromJson(Map<String, dynamic> json) =>
      _$JsonEntryFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEntryToJson(this);
}
