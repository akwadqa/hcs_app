// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderDetailsModel {

 OrderDetails get data;
/// Create a copy of OrderDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsModelCopyWith<OrderDetailsModel> get copyWith => _$OrderDetailsModelCopyWithImpl<OrderDetailsModel>(this as OrderDetailsModel, _$identity);

  /// Serializes this OrderDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsModel&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'OrderDetailsModel(data: $data)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsModelCopyWith<$Res>  {
  factory $OrderDetailsModelCopyWith(OrderDetailsModel value, $Res Function(OrderDetailsModel) _then) = _$OrderDetailsModelCopyWithImpl;
@useResult
$Res call({
 OrderDetails data
});


$OrderDetailsCopyWith<$Res> get data;

}
/// @nodoc
class _$OrderDetailsModelCopyWithImpl<$Res>
    implements $OrderDetailsModelCopyWith<$Res> {
  _$OrderDetailsModelCopyWithImpl(this._self, this._then);

  final OrderDetailsModel _self;
  final $Res Function(OrderDetailsModel) _then;

/// Create a copy of OrderDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OrderDetails,
  ));
}
/// Create a copy of OrderDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderDetailsCopyWith<$Res> get data {
  
  return $OrderDetailsCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _OrderDetailsModel implements OrderDetailsModel {
  const _OrderDetailsModel({required this.data});
  factory _OrderDetailsModel.fromJson(Map<String, dynamic> json) => _$OrderDetailsModelFromJson(json);

@override final  OrderDetails data;

/// Create a copy of OrderDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDetailsModelCopyWith<_OrderDetailsModel> get copyWith => __$OrderDetailsModelCopyWithImpl<_OrderDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDetailsModel&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'OrderDetailsModel(data: $data)';
}


}

/// @nodoc
abstract mixin class _$OrderDetailsModelCopyWith<$Res> implements $OrderDetailsModelCopyWith<$Res> {
  factory _$OrderDetailsModelCopyWith(_OrderDetailsModel value, $Res Function(_OrderDetailsModel) _then) = __$OrderDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 OrderDetails data
});


@override $OrderDetailsCopyWith<$Res> get data;

}
/// @nodoc
class __$OrderDetailsModelCopyWithImpl<$Res>
    implements _$OrderDetailsModelCopyWith<$Res> {
  __$OrderDetailsModelCopyWithImpl(this._self, this._then);

  final _OrderDetailsModel _self;
  final $Res Function(_OrderDetailsModel) _then;

/// Create a copy of OrderDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_OrderDetailsModel(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OrderDetails,
  ));
}

/// Create a copy of OrderDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderDetailsCopyWith<$Res> get data {
  
  return $OrderDetailsCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$OrderDetails {

 String? get status; Supervisor? get supervisor; Customer? get customer; Driver? get driver; String? get date;@JsonKey(name: "service_type") String? get serviceType;@JsonKey(name: "shift_type") String? get shiftType;@JsonKey(name: "with_cleaning_supplies") int? get withCleaningSupplies;@JsonKey(name: "discount_type") String? get discountType;@JsonKey(name: "discount_percentage") double? get discountPercentage;@JsonKey(name: "total_net_amount") double? get totalNetAmount;@JsonKey(name: "outstanding_amount") double? get outstandingAmount;@JsonKey(name: "method_of_payment") String? get methodOfPayment;@JsonKey(name: "skipcash_link") String? get skipcashLink;@JsonKey(name: "staff_appointment") List<String>? get staffAppointment;@JsonKey(name: "note") String? get note;@JsonKey(name: "days") List<String>? get days;
/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsCopyWith<OrderDetails> get copyWith => _$OrderDetailsCopyWithImpl<OrderDetails>(this as OrderDetails, _$identity);

  /// Serializes this OrderDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetails&&(identical(other.status, status) || other.status == status)&&(identical(other.supervisor, supervisor) || other.supervisor == supervisor)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.date, date) || other.date == date)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.withCleaningSupplies, withCleaningSupplies) || other.withCleaningSupplies == withCleaningSupplies)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.totalNetAmount, totalNetAmount) || other.totalNetAmount == totalNetAmount)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount)&&(identical(other.methodOfPayment, methodOfPayment) || other.methodOfPayment == methodOfPayment)&&(identical(other.skipcashLink, skipcashLink) || other.skipcashLink == skipcashLink)&&const DeepCollectionEquality().equals(other.staffAppointment, staffAppointment)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,supervisor,customer,driver,date,serviceType,shiftType,withCleaningSupplies,discountType,discountPercentage,totalNetAmount,outstandingAmount,methodOfPayment,skipcashLink,const DeepCollectionEquality().hash(staffAppointment),note,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'OrderDetails(status: $status, supervisor: $supervisor, customer: $customer, driver: $driver, date: $date, serviceType: $serviceType, shiftType: $shiftType, withCleaningSupplies: $withCleaningSupplies, discountType: $discountType, discountPercentage: $discountPercentage, totalNetAmount: $totalNetAmount, outstandingAmount: $outstandingAmount, methodOfPayment: $methodOfPayment, skipcashLink: $skipcashLink, staffAppointment: $staffAppointment, note: $note, days: $days)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsCopyWith<$Res>  {
  factory $OrderDetailsCopyWith(OrderDetails value, $Res Function(OrderDetails) _then) = _$OrderDetailsCopyWithImpl;
@useResult
$Res call({
 String? status, Supervisor? supervisor, Customer? customer, Driver? driver, String? date,@JsonKey(name: "service_type") String? serviceType,@JsonKey(name: "shift_type") String? shiftType,@JsonKey(name: "with_cleaning_supplies") int? withCleaningSupplies,@JsonKey(name: "discount_type") String? discountType,@JsonKey(name: "discount_percentage") double? discountPercentage,@JsonKey(name: "total_net_amount") double? totalNetAmount,@JsonKey(name: "outstanding_amount") double? outstandingAmount,@JsonKey(name: "method_of_payment") String? methodOfPayment,@JsonKey(name: "skipcash_link") String? skipcashLink,@JsonKey(name: "staff_appointment") List<String>? staffAppointment,@JsonKey(name: "note") String? note,@JsonKey(name: "days") List<String>? days
});


$SupervisorCopyWith<$Res>? get supervisor;$CustomerCopyWith<$Res>? get customer;$DriverCopyWith<$Res>? get driver;

}
/// @nodoc
class _$OrderDetailsCopyWithImpl<$Res>
    implements $OrderDetailsCopyWith<$Res> {
  _$OrderDetailsCopyWithImpl(this._self, this._then);

  final OrderDetails _self;
  final $Res Function(OrderDetails) _then;

/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? supervisor = freezed,Object? customer = freezed,Object? driver = freezed,Object? date = freezed,Object? serviceType = freezed,Object? shiftType = freezed,Object? withCleaningSupplies = freezed,Object? discountType = freezed,Object? discountPercentage = freezed,Object? totalNetAmount = freezed,Object? outstandingAmount = freezed,Object? methodOfPayment = freezed,Object? skipcashLink = freezed,Object? staffAppointment = freezed,Object? note = freezed,Object? days = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,supervisor: freezed == supervisor ? _self.supervisor : supervisor // ignore: cast_nullable_to_non_nullable
as Supervisor?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer?,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as Driver?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,shiftType: freezed == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String?,withCleaningSupplies: freezed == withCleaningSupplies ? _self.withCleaningSupplies : withCleaningSupplies // ignore: cast_nullable_to_non_nullable
as int?,discountType: freezed == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,totalNetAmount: freezed == totalNetAmount ? _self.totalNetAmount : totalNetAmount // ignore: cast_nullable_to_non_nullable
as double?,outstandingAmount: freezed == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as double?,methodOfPayment: freezed == methodOfPayment ? _self.methodOfPayment : methodOfPayment // ignore: cast_nullable_to_non_nullable
as String?,skipcashLink: freezed == skipcashLink ? _self.skipcashLink : skipcashLink // ignore: cast_nullable_to_non_nullable
as String?,staffAppointment: freezed == staffAppointment ? _self.staffAppointment : staffAppointment // ignore: cast_nullable_to_non_nullable
as List<String>?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,days: freezed == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupervisorCopyWith<$Res>? get supervisor {
    if (_self.supervisor == null) {
    return null;
  }

  return $SupervisorCopyWith<$Res>(_self.supervisor!, (value) {
    return _then(_self.copyWith(supervisor: value));
  });
}/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverCopyWith<$Res>? get driver {
    if (_self.driver == null) {
    return null;
  }

  return $DriverCopyWith<$Res>(_self.driver!, (value) {
    return _then(_self.copyWith(driver: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _OrderDetails implements OrderDetails {
  const _OrderDetails({required this.status, required this.supervisor, required this.customer, required this.driver, required this.date, @JsonKey(name: "service_type") required this.serviceType, @JsonKey(name: "shift_type") required this.shiftType, @JsonKey(name: "with_cleaning_supplies") required this.withCleaningSupplies, @JsonKey(name: "discount_type") this.discountType, @JsonKey(name: "discount_percentage") required this.discountPercentage, @JsonKey(name: "total_net_amount") required this.totalNetAmount, @JsonKey(name: "outstanding_amount") required this.outstandingAmount, @JsonKey(name: "method_of_payment") required this.methodOfPayment, @JsonKey(name: "skipcash_link") required this.skipcashLink, @JsonKey(name: "staff_appointment") required final  List<String>? staffAppointment, @JsonKey(name: "note") required this.note, @JsonKey(name: "days") required final  List<String>? days}): _staffAppointment = staffAppointment,_days = days;
  factory _OrderDetails.fromJson(Map<String, dynamic> json) => _$OrderDetailsFromJson(json);

@override final  String? status;
@override final  Supervisor? supervisor;
@override final  Customer? customer;
@override final  Driver? driver;
@override final  String? date;
@override@JsonKey(name: "service_type") final  String? serviceType;
@override@JsonKey(name: "shift_type") final  String? shiftType;
@override@JsonKey(name: "with_cleaning_supplies") final  int? withCleaningSupplies;
@override@JsonKey(name: "discount_type") final  String? discountType;
@override@JsonKey(name: "discount_percentage") final  double? discountPercentage;
@override@JsonKey(name: "total_net_amount") final  double? totalNetAmount;
@override@JsonKey(name: "outstanding_amount") final  double? outstandingAmount;
@override@JsonKey(name: "method_of_payment") final  String? methodOfPayment;
@override@JsonKey(name: "skipcash_link") final  String? skipcashLink;
 final  List<String>? _staffAppointment;
@override@JsonKey(name: "staff_appointment") List<String>? get staffAppointment {
  final value = _staffAppointment;
  if (value == null) return null;
  if (_staffAppointment is EqualUnmodifiableListView) return _staffAppointment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "note") final  String? note;
 final  List<String>? _days;
@override@JsonKey(name: "days") List<String>? get days {
  final value = _days;
  if (value == null) return null;
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDetailsCopyWith<_OrderDetails> get copyWith => __$OrderDetailsCopyWithImpl<_OrderDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDetails&&(identical(other.status, status) || other.status == status)&&(identical(other.supervisor, supervisor) || other.supervisor == supervisor)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.date, date) || other.date == date)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.shiftType, shiftType) || other.shiftType == shiftType)&&(identical(other.withCleaningSupplies, withCleaningSupplies) || other.withCleaningSupplies == withCleaningSupplies)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.totalNetAmount, totalNetAmount) || other.totalNetAmount == totalNetAmount)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount)&&(identical(other.methodOfPayment, methodOfPayment) || other.methodOfPayment == methodOfPayment)&&(identical(other.skipcashLink, skipcashLink) || other.skipcashLink == skipcashLink)&&const DeepCollectionEquality().equals(other._staffAppointment, _staffAppointment)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,supervisor,customer,driver,date,serviceType,shiftType,withCleaningSupplies,discountType,discountPercentage,totalNetAmount,outstandingAmount,methodOfPayment,skipcashLink,const DeepCollectionEquality().hash(_staffAppointment),note,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'OrderDetails(status: $status, supervisor: $supervisor, customer: $customer, driver: $driver, date: $date, serviceType: $serviceType, shiftType: $shiftType, withCleaningSupplies: $withCleaningSupplies, discountType: $discountType, discountPercentage: $discountPercentage, totalNetAmount: $totalNetAmount, outstandingAmount: $outstandingAmount, methodOfPayment: $methodOfPayment, skipcashLink: $skipcashLink, staffAppointment: $staffAppointment, note: $note, days: $days)';
}


}

/// @nodoc
abstract mixin class _$OrderDetailsCopyWith<$Res> implements $OrderDetailsCopyWith<$Res> {
  factory _$OrderDetailsCopyWith(_OrderDetails value, $Res Function(_OrderDetails) _then) = __$OrderDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? status, Supervisor? supervisor, Customer? customer, Driver? driver, String? date,@JsonKey(name: "service_type") String? serviceType,@JsonKey(name: "shift_type") String? shiftType,@JsonKey(name: "with_cleaning_supplies") int? withCleaningSupplies,@JsonKey(name: "discount_type") String? discountType,@JsonKey(name: "discount_percentage") double? discountPercentage,@JsonKey(name: "total_net_amount") double? totalNetAmount,@JsonKey(name: "outstanding_amount") double? outstandingAmount,@JsonKey(name: "method_of_payment") String? methodOfPayment,@JsonKey(name: "skipcash_link") String? skipcashLink,@JsonKey(name: "staff_appointment") List<String>? staffAppointment,@JsonKey(name: "note") String? note,@JsonKey(name: "days") List<String>? days
});


@override $SupervisorCopyWith<$Res>? get supervisor;@override $CustomerCopyWith<$Res>? get customer;@override $DriverCopyWith<$Res>? get driver;

}
/// @nodoc
class __$OrderDetailsCopyWithImpl<$Res>
    implements _$OrderDetailsCopyWith<$Res> {
  __$OrderDetailsCopyWithImpl(this._self, this._then);

  final _OrderDetails _self;
  final $Res Function(_OrderDetails) _then;

/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? supervisor = freezed,Object? customer = freezed,Object? driver = freezed,Object? date = freezed,Object? serviceType = freezed,Object? shiftType = freezed,Object? withCleaningSupplies = freezed,Object? discountType = freezed,Object? discountPercentage = freezed,Object? totalNetAmount = freezed,Object? outstandingAmount = freezed,Object? methodOfPayment = freezed,Object? skipcashLink = freezed,Object? staffAppointment = freezed,Object? note = freezed,Object? days = freezed,}) {
  return _then(_OrderDetails(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,supervisor: freezed == supervisor ? _self.supervisor : supervisor // ignore: cast_nullable_to_non_nullable
as Supervisor?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer?,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as Driver?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,shiftType: freezed == shiftType ? _self.shiftType : shiftType // ignore: cast_nullable_to_non_nullable
as String?,withCleaningSupplies: freezed == withCleaningSupplies ? _self.withCleaningSupplies : withCleaningSupplies // ignore: cast_nullable_to_non_nullable
as int?,discountType: freezed == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,totalNetAmount: freezed == totalNetAmount ? _self.totalNetAmount : totalNetAmount // ignore: cast_nullable_to_non_nullable
as double?,outstandingAmount: freezed == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as double?,methodOfPayment: freezed == methodOfPayment ? _self.methodOfPayment : methodOfPayment // ignore: cast_nullable_to_non_nullable
as String?,skipcashLink: freezed == skipcashLink ? _self.skipcashLink : skipcashLink // ignore: cast_nullable_to_non_nullable
as String?,staffAppointment: freezed == staffAppointment ? _self._staffAppointment : staffAppointment // ignore: cast_nullable_to_non_nullable
as List<String>?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,days: freezed == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupervisorCopyWith<$Res>? get supervisor {
    if (_self.supervisor == null) {
    return null;
  }

  return $SupervisorCopyWith<$Res>(_self.supervisor!, (value) {
    return _then(_self.copyWith(supervisor: value));
  });
}/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of OrderDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverCopyWith<$Res>? get driver {
    if (_self.driver == null) {
    return null;
  }

  return $DriverCopyWith<$Res>(_self.driver!, (value) {
    return _then(_self.copyWith(driver: value));
  });
}
}


/// @nodoc
mixin _$Supervisor {

 String get supervisor;@JsonKey(name: "supervisor_name") String? get supervisorName;
/// Create a copy of Supervisor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupervisorCopyWith<Supervisor> get copyWith => _$SupervisorCopyWithImpl<Supervisor>(this as Supervisor, _$identity);

  /// Serializes this Supervisor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Supervisor&&(identical(other.supervisor, supervisor) || other.supervisor == supervisor)&&(identical(other.supervisorName, supervisorName) || other.supervisorName == supervisorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supervisor,supervisorName);

@override
String toString() {
  return 'Supervisor(supervisor: $supervisor, supervisorName: $supervisorName)';
}


}

/// @nodoc
abstract mixin class $SupervisorCopyWith<$Res>  {
  factory $SupervisorCopyWith(Supervisor value, $Res Function(Supervisor) _then) = _$SupervisorCopyWithImpl;
@useResult
$Res call({
 String supervisor,@JsonKey(name: "supervisor_name") String? supervisorName
});




}
/// @nodoc
class _$SupervisorCopyWithImpl<$Res>
    implements $SupervisorCopyWith<$Res> {
  _$SupervisorCopyWithImpl(this._self, this._then);

  final Supervisor _self;
  final $Res Function(Supervisor) _then;

/// Create a copy of Supervisor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? supervisor = null,Object? supervisorName = freezed,}) {
  return _then(_self.copyWith(
supervisor: null == supervisor ? _self.supervisor : supervisor // ignore: cast_nullable_to_non_nullable
as String,supervisorName: freezed == supervisorName ? _self.supervisorName : supervisorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Supervisor implements Supervisor {
  const _Supervisor({required this.supervisor, @JsonKey(name: "supervisor_name") required this.supervisorName});
  factory _Supervisor.fromJson(Map<String, dynamic> json) => _$SupervisorFromJson(json);

@override final  String supervisor;
@override@JsonKey(name: "supervisor_name") final  String? supervisorName;

/// Create a copy of Supervisor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupervisorCopyWith<_Supervisor> get copyWith => __$SupervisorCopyWithImpl<_Supervisor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupervisorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Supervisor&&(identical(other.supervisor, supervisor) || other.supervisor == supervisor)&&(identical(other.supervisorName, supervisorName) || other.supervisorName == supervisorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supervisor,supervisorName);

@override
String toString() {
  return 'Supervisor(supervisor: $supervisor, supervisorName: $supervisorName)';
}


}

/// @nodoc
abstract mixin class _$SupervisorCopyWith<$Res> implements $SupervisorCopyWith<$Res> {
  factory _$SupervisorCopyWith(_Supervisor value, $Res Function(_Supervisor) _then) = __$SupervisorCopyWithImpl;
@override @useResult
$Res call({
 String supervisor,@JsonKey(name: "supervisor_name") String? supervisorName
});




}
/// @nodoc
class __$SupervisorCopyWithImpl<$Res>
    implements _$SupervisorCopyWith<$Res> {
  __$SupervisorCopyWithImpl(this._self, this._then);

  final _Supervisor _self;
  final $Res Function(_Supervisor) _then;

/// Create a copy of Supervisor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? supervisor = null,Object? supervisorName = freezed,}) {
  return _then(_Supervisor(
supervisor: null == supervisor ? _self.supervisor : supervisor // ignore: cast_nullable_to_non_nullable
as String,supervisorName: freezed == supervisorName ? _self.supervisorName : supervisorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Customer {

@JsonKey(name: "customer_id") String? get customerId;@JsonKey(name: "customer_name") String? get customerName; String? get location;@JsonKey(name: "location_url") String? get locationUrl; String? get zone;@JsonKey(name: "phone_number") String? get phoneNumber;
/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerCopyWith<Customer> get copyWith => _$CustomerCopyWithImpl<Customer>(this as Customer, _$identity);

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Customer&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationUrl, locationUrl) || other.locationUrl == locationUrl)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerId,customerName,location,locationUrl,zone,phoneNumber);

@override
String toString() {
  return 'Customer(customerId: $customerId, customerName: $customerName, location: $location, locationUrl: $locationUrl, zone: $zone, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $CustomerCopyWith<$Res>  {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) _then) = _$CustomerCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "customer_id") String? customerId,@JsonKey(name: "customer_name") String? customerName, String? location,@JsonKey(name: "location_url") String? locationUrl, String? zone,@JsonKey(name: "phone_number") String? phoneNumber
});




}
/// @nodoc
class _$CustomerCopyWithImpl<$Res>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._self, this._then);

  final Customer _self;
  final $Res Function(Customer) _then;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerId = freezed,Object? customerName = freezed,Object? location = freezed,Object? locationUrl = freezed,Object? zone = freezed,Object? phoneNumber = freezed,}) {
  return _then(_self.copyWith(
customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,locationUrl: freezed == locationUrl ? _self.locationUrl : locationUrl // ignore: cast_nullable_to_non_nullable
as String?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Customer implements Customer {
  const _Customer({@JsonKey(name: "customer_id") required this.customerId, @JsonKey(name: "customer_name") required this.customerName, required this.location, @JsonKey(name: "location_url") required this.locationUrl, required this.zone, @JsonKey(name: "phone_number") required this.phoneNumber});
  factory _Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

@override@JsonKey(name: "customer_id") final  String? customerId;
@override@JsonKey(name: "customer_name") final  String? customerName;
@override final  String? location;
@override@JsonKey(name: "location_url") final  String? locationUrl;
@override final  String? zone;
@override@JsonKey(name: "phone_number") final  String? phoneNumber;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerCopyWith<_Customer> get copyWith => __$CustomerCopyWithImpl<_Customer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Customer&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationUrl, locationUrl) || other.locationUrl == locationUrl)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerId,customerName,location,locationUrl,zone,phoneNumber);

@override
String toString() {
  return 'Customer(customerId: $customerId, customerName: $customerName, location: $location, locationUrl: $locationUrl, zone: $zone, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$CustomerCopyWith<$Res> implements $CustomerCopyWith<$Res> {
  factory _$CustomerCopyWith(_Customer value, $Res Function(_Customer) _then) = __$CustomerCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "customer_id") String? customerId,@JsonKey(name: "customer_name") String? customerName, String? location,@JsonKey(name: "location_url") String? locationUrl, String? zone,@JsonKey(name: "phone_number") String? phoneNumber
});




}
/// @nodoc
class __$CustomerCopyWithImpl<$Res>
    implements _$CustomerCopyWith<$Res> {
  __$CustomerCopyWithImpl(this._self, this._then);

  final _Customer _self;
  final $Res Function(_Customer) _then;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerId = freezed,Object? customerName = freezed,Object? location = freezed,Object? locationUrl = freezed,Object? zone = freezed,Object? phoneNumber = freezed,}) {
  return _then(_Customer(
customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,locationUrl: freezed == locationUrl ? _self.locationUrl : locationUrl // ignore: cast_nullable_to_non_nullable
as String?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Driver {

@JsonKey(name: "driver_id") String? get driverId;@JsonKey(name: "driver_name") String? get driverName;@JsonKey(name: "current_driver_status") String? get currentDriverStatus;@JsonKey(name: "driver_status") List<DriverStatus>? get driverStatus;
/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverCopyWith<Driver> get copyWith => _$DriverCopyWithImpl<Driver>(this as Driver, _$identity);

  /// Serializes this Driver to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Driver&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.currentDriverStatus, currentDriverStatus) || other.currentDriverStatus == currentDriverStatus)&&const DeepCollectionEquality().equals(other.driverStatus, driverStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,driverId,driverName,currentDriverStatus,const DeepCollectionEquality().hash(driverStatus));

@override
String toString() {
  return 'Driver(driverId: $driverId, driverName: $driverName, currentDriverStatus: $currentDriverStatus, driverStatus: $driverStatus)';
}


}

/// @nodoc
abstract mixin class $DriverCopyWith<$Res>  {
  factory $DriverCopyWith(Driver value, $Res Function(Driver) _then) = _$DriverCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "driver_id") String? driverId,@JsonKey(name: "driver_name") String? driverName,@JsonKey(name: "current_driver_status") String? currentDriverStatus,@JsonKey(name: "driver_status") List<DriverStatus>? driverStatus
});




}
/// @nodoc
class _$DriverCopyWithImpl<$Res>
    implements $DriverCopyWith<$Res> {
  _$DriverCopyWithImpl(this._self, this._then);

  final Driver _self;
  final $Res Function(Driver) _then;

/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? driverId = freezed,Object? driverName = freezed,Object? currentDriverStatus = freezed,Object? driverStatus = freezed,}) {
  return _then(_self.copyWith(
driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,currentDriverStatus: freezed == currentDriverStatus ? _self.currentDriverStatus : currentDriverStatus // ignore: cast_nullable_to_non_nullable
as String?,driverStatus: freezed == driverStatus ? _self.driverStatus : driverStatus // ignore: cast_nullable_to_non_nullable
as List<DriverStatus>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Driver implements Driver {
  const _Driver({@JsonKey(name: "driver_id") required this.driverId, @JsonKey(name: "driver_name") required this.driverName, @JsonKey(name: "current_driver_status") required this.currentDriverStatus, @JsonKey(name: "driver_status") required final  List<DriverStatus>? driverStatus}): _driverStatus = driverStatus;
  factory _Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

@override@JsonKey(name: "driver_id") final  String? driverId;
@override@JsonKey(name: "driver_name") final  String? driverName;
@override@JsonKey(name: "current_driver_status") final  String? currentDriverStatus;
 final  List<DriverStatus>? _driverStatus;
@override@JsonKey(name: "driver_status") List<DriverStatus>? get driverStatus {
  final value = _driverStatus;
  if (value == null) return null;
  if (_driverStatus is EqualUnmodifiableListView) return _driverStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverCopyWith<_Driver> get copyWith => __$DriverCopyWithImpl<_Driver>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Driver&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.currentDriverStatus, currentDriverStatus) || other.currentDriverStatus == currentDriverStatus)&&const DeepCollectionEquality().equals(other._driverStatus, _driverStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,driverId,driverName,currentDriverStatus,const DeepCollectionEquality().hash(_driverStatus));

@override
String toString() {
  return 'Driver(driverId: $driverId, driverName: $driverName, currentDriverStatus: $currentDriverStatus, driverStatus: $driverStatus)';
}


}

/// @nodoc
abstract mixin class _$DriverCopyWith<$Res> implements $DriverCopyWith<$Res> {
  factory _$DriverCopyWith(_Driver value, $Res Function(_Driver) _then) = __$DriverCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "driver_id") String? driverId,@JsonKey(name: "driver_name") String? driverName,@JsonKey(name: "current_driver_status") String? currentDriverStatus,@JsonKey(name: "driver_status") List<DriverStatus>? driverStatus
});




}
/// @nodoc
class __$DriverCopyWithImpl<$Res>
    implements _$DriverCopyWith<$Res> {
  __$DriverCopyWithImpl(this._self, this._then);

  final _Driver _self;
  final $Res Function(_Driver) _then;

/// Create a copy of Driver
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? driverId = freezed,Object? driverName = freezed,Object? currentDriverStatus = freezed,Object? driverStatus = freezed,}) {
  return _then(_Driver(
driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,currentDriverStatus: freezed == currentDriverStatus ? _self.currentDriverStatus : currentDriverStatus // ignore: cast_nullable_to_non_nullable
as String?,driverStatus: freezed == driverStatus ? _self._driverStatus : driverStatus // ignore: cast_nullable_to_non_nullable
as List<DriverStatus>?,
  ));
}


}


/// @nodoc
mixin _$DriverStatus {

 String? get status; bool? get active;
/// Create a copy of DriverStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverStatusCopyWith<DriverStatus> get copyWith => _$DriverStatusCopyWithImpl<DriverStatus>(this as DriverStatus, _$identity);

  /// Serializes this DriverStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverStatus&&(identical(other.status, status) || other.status == status)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,active);

@override
String toString() {
  return 'DriverStatus(status: $status, active: $active)';
}


}

/// @nodoc
abstract mixin class $DriverStatusCopyWith<$Res>  {
  factory $DriverStatusCopyWith(DriverStatus value, $Res Function(DriverStatus) _then) = _$DriverStatusCopyWithImpl;
@useResult
$Res call({
 String? status, bool? active
});




}
/// @nodoc
class _$DriverStatusCopyWithImpl<$Res>
    implements $DriverStatusCopyWith<$Res> {
  _$DriverStatusCopyWithImpl(this._self, this._then);

  final DriverStatus _self;
  final $Res Function(DriverStatus) _then;

/// Create a copy of DriverStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? active = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DriverStatus implements DriverStatus {
  const _DriverStatus({required this.status, required this.active});
  factory _DriverStatus.fromJson(Map<String, dynamic> json) => _$DriverStatusFromJson(json);

@override final  String? status;
@override final  bool? active;

/// Create a copy of DriverStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverStatusCopyWith<_DriverStatus> get copyWith => __$DriverStatusCopyWithImpl<_DriverStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverStatus&&(identical(other.status, status) || other.status == status)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,active);

@override
String toString() {
  return 'DriverStatus(status: $status, active: $active)';
}


}

/// @nodoc
abstract mixin class _$DriverStatusCopyWith<$Res> implements $DriverStatusCopyWith<$Res> {
  factory _$DriverStatusCopyWith(_DriverStatus value, $Res Function(_DriverStatus) _then) = __$DriverStatusCopyWithImpl;
@override @useResult
$Res call({
 String? status, bool? active
});




}
/// @nodoc
class __$DriverStatusCopyWithImpl<$Res>
    implements _$DriverStatusCopyWith<$Res> {
  __$DriverStatusCopyWithImpl(this._self, this._then);

  final _DriverStatus _self;
  final $Res Function(_DriverStatus) _then;

/// Create a copy of DriverStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? active = freezed,}) {
  return _then(_DriverStatus(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
