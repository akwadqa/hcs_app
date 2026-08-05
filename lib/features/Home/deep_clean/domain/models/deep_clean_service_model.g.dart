// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_clean_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeepCleanServiceModel _$DeepCleanServiceModelFromJson(
  Map<String, dynamic> json,
) => _DeepCleanServiceModel(
  id: json['id'] as String,
  name: json['name'] as String,
  subtitle: json['subtitle'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  fields:
      (json['fields'] as List<dynamic>?)
          ?.map((e) => ServiceField.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$DeepCleanServiceModelToJson(
  _DeepCleanServiceModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'subtitle': instance.subtitle,
  'price': instance.price,
  'fields': instance.fields,
};
