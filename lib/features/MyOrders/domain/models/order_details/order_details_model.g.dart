// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderDetailsModel _$OrderDetailsModelFromJson(Map<String, dynamic> json) =>
    _OrderDetailsModel(
      data: OrderDetails.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailsModelToJson(_OrderDetailsModel instance) =>
    <String, dynamic>{'data': instance.data};

_OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) =>
    _OrderDetails(
      status: json['status'] as String?,
      supervisor: json['supervisor'] == null
          ? null
          : Supervisor.fromJson(json['supervisor'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      driver: json['driver'] == null
          ? null
          : Driver.fromJson(json['driver'] as Map<String, dynamic>),
      date: json['date'] as String?,
      serviceType: json['service_type'] as String?,
      shiftType: json['shift_type'] as String?,
      withCleaningSupplies: (json['with_cleaning_supplies'] as num?)?.toInt(),
      discountType: json['discount_type'] as String?,
      discountPercentage: (json['discount_percentage'] as num?)?.toDouble(),
      totalNetAmount: (json['total_net_amount'] as num?)?.toDouble(),
      outstandingAmount: (json['outstanding_amount'] as num?)?.toDouble(),
      methodOfPayment: json['method_of_payment'] as String?,
      skipcashLink: json['skipcash_link'] as String?,
      staffAppointment: (json['staff_appointment'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      note: json['note'] as String?,
      days: (json['days'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OrderDetailsToJson(_OrderDetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'supervisor': instance.supervisor,
      'customer': instance.customer,
      'driver': instance.driver,
      'date': instance.date,
      'service_type': instance.serviceType,
      'shift_type': instance.shiftType,
      'with_cleaning_supplies': instance.withCleaningSupplies,
      'discount_type': instance.discountType,
      'discount_percentage': instance.discountPercentage,
      'total_net_amount': instance.totalNetAmount,
      'outstanding_amount': instance.outstandingAmount,
      'method_of_payment': instance.methodOfPayment,
      'skipcash_link': instance.skipcashLink,
      'staff_appointment': instance.staffAppointment,
      'note': instance.note,
      'days': instance.days,
    };

_Supervisor _$SupervisorFromJson(Map<String, dynamic> json) => _Supervisor(
  supervisor: json['supervisor'] as String,
  supervisorName: json['supervisor_name'] as String?,
);

Map<String, dynamic> _$SupervisorToJson(_Supervisor instance) =>
    <String, dynamic>{
      'supervisor': instance.supervisor,
      'supervisor_name': instance.supervisorName,
    };

_Customer _$CustomerFromJson(Map<String, dynamic> json) => _Customer(
  customerId: json['customer_id'] as String?,
  customerName: json['customer_name'] as String?,
  location: json['location'] as String?,
  locationUrl: json['location_url'] as String?,
  zone: json['zone'] as String?,
  phoneNumber: json['phone_number'] as String?,
);

Map<String, dynamic> _$CustomerToJson(_Customer instance) => <String, dynamic>{
  'customer_id': instance.customerId,
  'customer_name': instance.customerName,
  'location': instance.location,
  'location_url': instance.locationUrl,
  'zone': instance.zone,
  'phone_number': instance.phoneNumber,
};

_Driver _$DriverFromJson(Map<String, dynamic> json) => _Driver(
  driverId: json['driver_id'] as String?,
  driverName: json['driver_name'] as String?,
  currentDriverStatus: json['current_driver_status'] as String?,
  driverStatus: (json['driver_status'] as List<dynamic>?)
      ?.map((e) => DriverStatus.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DriverToJson(_Driver instance) => <String, dynamic>{
  'driver_id': instance.driverId,
  'driver_name': instance.driverName,
  'current_driver_status': instance.currentDriverStatus,
  'driver_status': instance.driverStatus,
};

_DriverStatus _$DriverStatusFromJson(Map<String, dynamic> json) =>
    _DriverStatus(
      status: json['status'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$DriverStatusToJson(_DriverStatus instance) =>
    <String, dynamic>{'status': instance.status, 'active': instance.active};
