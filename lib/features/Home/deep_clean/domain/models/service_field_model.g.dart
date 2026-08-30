// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FieldOption _$FieldOptionFromJson(Map<String, dynamic> json) => _FieldOption(
  id: json['id'] as String,
  label: json['label'] as String,
  price: (json['price'] as num?)?.toDouble(),
  isQuote: json['is_quote'] as bool? ?? false,
);

Map<String, dynamic> _$FieldOptionToJson(_FieldOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'price': instance.price,
      'is_quote': instance.isQuote,
    };

_ServiceField _$ServiceFieldFromJson(
  Map<String, dynamic> json,
) => _ServiceField(
  key: json['key'] as String,
  label: json['label'] as String,
  type: $enumDecodeNullable(_$FieldTypeEnumMap, json['type']) ?? FieldType.text,
  required: json['required'] as bool? ?? true,
  hint: json['hint'] as String?,
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => FieldOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  dependsOn: json['depends_on'] as String?,
  optionsByParent: (json['options_by_parent'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(
      k,
      (e as List<dynamic>)
          .map((e) => FieldOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  ),
);

Map<String, dynamic> _$ServiceFieldToJson(_ServiceField instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type]!,
      'required': instance.required,
      'hint': instance.hint,
      'options': instance.options,
      'depends_on': instance.dependsOn,
      'options_by_parent': instance.optionsByParent,
    };

const _$FieldTypeEnumMap = {
  FieldType.dropdown: 'dropdown',
  FieldType.text: 'text',
  FieldType.number: 'number',
  FieldType.date: 'date',
};
