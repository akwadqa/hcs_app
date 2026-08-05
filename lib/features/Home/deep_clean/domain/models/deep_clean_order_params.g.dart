// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_clean_order_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeepCleanOrderParams _$DeepCleanOrderParamsFromJson(
  Map<String, dynamic> json,
) => _DeepCleanOrderParams(
  customerId: json['customer_id'] as String,
  serviceIds: (json['service_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  serviceType: json['service_type'] as String,
  shift: json['shift'] as String,
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$DeepCleanOrderParamsToJson(
  _DeepCleanOrderParams instance,
) => <String, dynamic>{
  'customer_id': instance.customerId,
  'service_ids': instance.serviceIds,
  'service_type': instance.serviceType,
  'shift': instance.shift,
  'date': instance.date.toIso8601String(),
};
