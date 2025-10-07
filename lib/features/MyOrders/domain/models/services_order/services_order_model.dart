import 'package:freezed_annotation/freezed_annotation.dart';

part 'services_order_model.freezed.dart';
part 'services_order_model.g.dart';

@freezed
abstract class ServicesOrder with _$ServicesOrder {
  const factory ServicesOrder({
    @JsonKey(name: "orders") List<Order>? orders,
    @JsonKey(name: "totals") Totals? totals,
  }) = _ServicesOrder;

  factory ServicesOrder.fromJson(Map<String, dynamic> json) =>
      _$ServicesOrderFromJson(json);
}

@freezed
abstract class Order with _$Order {
  const factory Order({
    @JsonKey(name: "service_order_id") String? serviceOrderId,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "posting_date") String? postingDate,
    @JsonKey(name: "service_type") String? serviceType,
    @JsonKey(name: "total_net_amount") int? totalNetAmount,
    @JsonKey(name: "outstanding_amount") int? outstandingAmount,
    @JsonKey(name: "received_amount") int? receivedAmount,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
abstract class Totals with _$Totals {
  const factory Totals({
    @JsonKey(name: "total_outstanding_amount") int? totalOutstandingAmount,
    @JsonKey(name: "total_net_amount") int? totalNetAmount,
    @JsonKey(name: "total_received_amount") int? totalReceivedAmount,
  }) = _Totals;

  factory Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);
}
