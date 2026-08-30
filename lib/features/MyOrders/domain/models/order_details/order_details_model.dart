import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_details_model.freezed.dart';
part 'order_details_model.g.dart';

@freezed
abstract class OrderDetailsModel with _$OrderDetailsModel {
  const factory OrderDetailsModel({required OrderDetails data}) =
      _OrderDetailsModel;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsModelFromJson(json);
}

@freezed
abstract class OrderDetails with _$OrderDetails {
  const factory OrderDetails({
    required String? status,
    required Supervisor? supervisor,
    required Customer? customer,
    required Driver? driver,
    required String? date,
    @JsonKey(name: "service_type") required String? serviceType,
    @JsonKey(name: "shift_type") required String? shiftType,
    @JsonKey(name: "with_cleaning_supplies") required int? withCleaningSupplies,
    @JsonKey(name: "discount_type") String? discountType,
    @JsonKey(name: "discount_percentage") required double? discountPercentage,
    @JsonKey(name: "total_net_amount") required double? totalNetAmount,
    @JsonKey(name: "outstanding_amount") required double? outstandingAmount,
    @JsonKey(name: "method_of_payment") required String? methodOfPayment,
    @JsonKey(name: "skipcash_link") required String? skipcashLink,
    @JsonKey(name: "staff_appointment") required List<String>? staffAppointment,
    @JsonKey(name: "note") required String? note,
    @JsonKey(name: "days") required List<String>? days,
  }) = _OrderDetails;

  factory OrderDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsFromJson(json);
}

@freezed
abstract class Supervisor with _$Supervisor {
  const factory Supervisor({
    required String supervisor,
    @JsonKey(name: "supervisor_name") required String? supervisorName,
  }) = _Supervisor;

  factory Supervisor.fromJson(Map<String, dynamic> json) =>
      _$SupervisorFromJson(json);
}

@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    @JsonKey(name: "customer_id") required String? customerId,
    @JsonKey(name: "customer_name") required String? customerName,
    required String? location,
    @JsonKey(name: "location_url") required String? locationUrl,
    required String? zone,
    @JsonKey(name: "phone_number") required String? phoneNumber,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

@freezed
abstract class Driver with _$Driver {
  const factory Driver({
    @JsonKey(name: "driver_id") required String? driverId,
    @JsonKey(name: "driver_name") required String? driverName,
    @JsonKey(name: "current_driver_status") required String? currentDriverStatus,
    @JsonKey(name: "driver_status") required List<DriverStatus>? driverStatus,
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}

@freezed
abstract class DriverStatus with _$DriverStatus {
  const factory DriverStatus({required String? status, required bool? active}) =
      _DriverStatus;

  factory DriverStatus.fromJson(Map<String, dynamic> json) =>
      _$DriverStatusFromJson(json);
}
