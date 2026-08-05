// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_clean_services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeepCleanServicesResponse _$DeepCleanServicesResponseFromJson(
  Map<String, dynamic> json,
) => _DeepCleanServicesResponse(
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => DeepCleanServiceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$DeepCleanServicesResponseToJson(
  _DeepCleanServicesResponse instance,
) => <String, dynamic>{'data': instance.data};
