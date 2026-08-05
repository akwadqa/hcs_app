import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_field_model.freezed.dart';
part 'service_field_model.g.dart';

enum FieldType {
  @JsonValue('dropdown') dropdown,
  @JsonValue('text')     text,
  @JsonValue('number')   number,
  @JsonValue('date')     date,
}

@freezed
abstract class FieldOption with _$FieldOption {
  const factory FieldOption({
    required String id,
    required String label,
    double? price,
    @Default(false) @JsonKey(name: 'is_quote') bool isQuote,
  }) = _FieldOption;

  factory FieldOption.fromJson(Map<String, dynamic> json) =>
      _$FieldOptionFromJson(json);
}

@freezed
abstract class ServiceField with _$ServiceField {
  const factory ServiceField({
    required String key,
    required String label,
    @Default(FieldType.text) FieldType type,
    @Default(true) bool required,
    String? hint,
    @Default([]) List<FieldOption> options,
    @JsonKey(name: 'depends_on') String? dependsOn,
    @JsonKey(name: 'options_by_parent')
    Map<String, List<FieldOption>>? optionsByParent,
  }) = _ServiceField;

  factory ServiceField.fromJson(Map<String, dynamic> json) =>
      _$ServiceFieldFromJson(json);
}