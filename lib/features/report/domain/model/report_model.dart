// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class OrdersReport {
  @JsonKey(name: 'orders')
  List<ReportModel> reports;
  @JsonKey(name: 'totals')
  Totals total;
  OrdersReport({
    required this.reports,
    required this.total,
  });
    factory OrdersReport.fromJson(Map<String, dynamic> json) =>
      _$OrdersReportFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersReportToJson(this);

}

@JsonSerializable()
class Totals {
  @JsonKey(name: "total_outstanding_amount")
  int totalOutstandingAmount;
  @JsonKey(name: "total_net_amount")
  int totalNetAmount;
  @JsonKey(name: "total_received_amount")
  int totalReceivedAmount;
  Totals({
    required this.totalOutstandingAmount,
    required this.totalNetAmount,
    required this.totalReceivedAmount,
  });
  factory Totals.fromJson(Map<String, dynamic> json) =>
      _$TotalsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalsToJson(this);
}

@JsonSerializable()
class ReportModel {
  @JsonKey(name: 'service_order_id')
  String serviceOrderId;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'posting_date')
  String postingDate;
  @JsonKey(name: 'service_type')
  String serviceType;
  @JsonKey(name: 'total_net_amount')
  int totalNetAmount;
  ReportModel({
    required this.serviceOrderId,
    required this.status,
    required this.postingDate,
    required this.serviceType,
    required this.totalNetAmount,
  });

    factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
  
}
