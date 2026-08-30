// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServicesOrder _$ServicesOrderFromJson(Map<String, dynamic> json) =>
    _ServicesOrder(
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: json['totals'] == null
          ? null
          : Totals.fromJson(json['totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServicesOrderToJson(_ServicesOrder instance) =>
    <String, dynamic>{'orders': instance.orders, 'totals': instance.totals};

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
  serviceOrderId: json['service_order_id'] as String?,
  status: json['status'] as String?,
  postingDate: json['posting_date'] as String?,
  serviceType: json['service_type'] as String?,
  totalNetAmount: (json['total_net_amount'] as num?)?.toInt(),
  outstandingAmount: (json['outstanding_amount'] as num?)?.toInt(),
  receivedAmount: (json['received_amount'] as num?)?.toInt(),
);

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
  'service_order_id': instance.serviceOrderId,
  'status': instance.status,
  'posting_date': instance.postingDate,
  'service_type': instance.serviceType,
  'total_net_amount': instance.totalNetAmount,
  'outstanding_amount': instance.outstandingAmount,
  'received_amount': instance.receivedAmount,
};

_Totals _$TotalsFromJson(Map<String, dynamic> json) => _Totals(
  totalOutstandingAmount: (json['total_outstanding_amount'] as num?)?.toInt(),
  totalNetAmount: (json['total_net_amount'] as num?)?.toInt(),
  totalReceivedAmount: (json['total_received_amount'] as num?)?.toInt(),
);

Map<String, dynamic> _$TotalsToJson(_Totals instance) => <String, dynamic>{
  'total_outstanding_amount': instance.totalOutstandingAmount,
  'total_net_amount': instance.totalNetAmount,
  'total_received_amount': instance.totalReceivedAmount,
};
