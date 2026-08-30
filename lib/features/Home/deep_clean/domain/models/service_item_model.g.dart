// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceItemModel _$ServiceItemModelFromJson(Map<String, dynamic> json) =>
    _ServiceItemModel(
      itemCode: json['item_code'] as String,
      itemName: json['item_name'] as String,
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ServiceItemModelToJson(_ServiceItemModel instance) =>
    <String, dynamic>{
      'item_code': instance.itemCode,
      'item_name': instance.itemName,
      'rate': instance.rate,
    };
