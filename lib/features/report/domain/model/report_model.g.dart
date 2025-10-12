// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersReport _$OrdersReportFromJson(Map<String, dynamic> json) => OrdersReport(
  reports: (json['orders'] as List<dynamic>)
      .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: Totals.fromJson(json['totals'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrdersReportToJson(OrdersReport instance) =>
    <String, dynamic>{'orders': instance.reports, 'totals': instance.total};

Totals _$TotalsFromJson(Map<String, dynamic> json) => Totals(
  totalOutstandingAmount: (json['total_outstanding_amount'] as num).toInt(),
  totalNetAmount: (json['total_net_amount'] as num).toInt(),
  totalReceivedAmount: (json['total_received_amount'] as num).toInt(),
);

Map<String, dynamic> _$TotalsToJson(Totals instance) => <String, dynamic>{
  'total_outstanding_amount': instance.totalOutstandingAmount,
  'total_net_amount': instance.totalNetAmount,
  'total_received_amount': instance.totalReceivedAmount,
};

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
  serviceOrderId: json['service_order_id'] as String,
  status: json['status'] as String,
  methodOfPayment: json['method_of_payment'] as String,
  postingDate: json['posting_date'] as String,
  serviceType: json['service_type'] as String,
  totalNetAmount: (json['total_net_amount'] as num).toInt(),
);

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'service_order_id': instance.serviceOrderId,
      'status': instance.status,
      'posting_date': instance.postingDate,
      'service_type': instance.serviceType,
      'method_of_payment': instance.methodOfPayment,
      'total_net_amount': instance.totalNetAmount,
    };
