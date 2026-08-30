// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServicesOrder {

@JsonKey(name: "orders") List<Order>? get orders;@JsonKey(name: "totals") Totals? get totals;
/// Create a copy of ServicesOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesOrderCopyWith<ServicesOrder> get copyWith => _$ServicesOrderCopyWithImpl<ServicesOrder>(this as ServicesOrder, _$identity);

  /// Serializes this ServicesOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesOrder&&const DeepCollectionEquality().equals(other.orders, orders)&&(identical(other.totals, totals) || other.totals == totals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(orders),totals);

@override
String toString() {
  return 'ServicesOrder(orders: $orders, totals: $totals)';
}


}

/// @nodoc
abstract mixin class $ServicesOrderCopyWith<$Res>  {
  factory $ServicesOrderCopyWith(ServicesOrder value, $Res Function(ServicesOrder) _then) = _$ServicesOrderCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "orders") List<Order>? orders,@JsonKey(name: "totals") Totals? totals
});


$TotalsCopyWith<$Res>? get totals;

}
/// @nodoc
class _$ServicesOrderCopyWithImpl<$Res>
    implements $ServicesOrderCopyWith<$Res> {
  _$ServicesOrderCopyWithImpl(this._self, this._then);

  final ServicesOrder _self;
  final $Res Function(ServicesOrder) _then;

/// Create a copy of ServicesOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orders = freezed,Object? totals = freezed,}) {
  return _then(_self.copyWith(
orders: freezed == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<Order>?,totals: freezed == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as Totals?,
  ));
}
/// Create a copy of ServicesOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsCopyWith<$Res>? get totals {
    if (_self.totals == null) {
    return null;
  }

  return $TotalsCopyWith<$Res>(_self.totals!, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ServicesOrder implements ServicesOrder {
  const _ServicesOrder({@JsonKey(name: "orders") final  List<Order>? orders, @JsonKey(name: "totals") this.totals}): _orders = orders;
  factory _ServicesOrder.fromJson(Map<String, dynamic> json) => _$ServicesOrderFromJson(json);

 final  List<Order>? _orders;
@override@JsonKey(name: "orders") List<Order>? get orders {
  final value = _orders;
  if (value == null) return null;
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "totals") final  Totals? totals;

/// Create a copy of ServicesOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicesOrderCopyWith<_ServicesOrder> get copyWith => __$ServicesOrderCopyWithImpl<_ServicesOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServicesOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicesOrder&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.totals, totals) || other.totals == totals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders),totals);

@override
String toString() {
  return 'ServicesOrder(orders: $orders, totals: $totals)';
}


}

/// @nodoc
abstract mixin class _$ServicesOrderCopyWith<$Res> implements $ServicesOrderCopyWith<$Res> {
  factory _$ServicesOrderCopyWith(_ServicesOrder value, $Res Function(_ServicesOrder) _then) = __$ServicesOrderCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "orders") List<Order>? orders,@JsonKey(name: "totals") Totals? totals
});


@override $TotalsCopyWith<$Res>? get totals;

}
/// @nodoc
class __$ServicesOrderCopyWithImpl<$Res>
    implements _$ServicesOrderCopyWith<$Res> {
  __$ServicesOrderCopyWithImpl(this._self, this._then);

  final _ServicesOrder _self;
  final $Res Function(_ServicesOrder) _then;

/// Create a copy of ServicesOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orders = freezed,Object? totals = freezed,}) {
  return _then(_ServicesOrder(
orders: freezed == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<Order>?,totals: freezed == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as Totals?,
  ));
}

/// Create a copy of ServicesOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TotalsCopyWith<$Res>? get totals {
    if (_self.totals == null) {
    return null;
  }

  return $TotalsCopyWith<$Res>(_self.totals!, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// @nodoc
mixin _$Order {

@JsonKey(name: "service_order_id") String? get serviceOrderId;@JsonKey(name: "status") String? get status;@JsonKey(name: "posting_date") String? get postingDate;@JsonKey(name: "service_type") String? get serviceType;@JsonKey(name: "total_net_amount") int? get totalNetAmount;@JsonKey(name: "outstanding_amount") int? get outstandingAmount;@JsonKey(name: "received_amount") int? get receivedAmount;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.serviceOrderId, serviceOrderId) || other.serviceOrderId == serviceOrderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.totalNetAmount, totalNetAmount) || other.totalNetAmount == totalNetAmount)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount)&&(identical(other.receivedAmount, receivedAmount) || other.receivedAmount == receivedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceOrderId,status,postingDate,serviceType,totalNetAmount,outstandingAmount,receivedAmount);

@override
String toString() {
  return 'Order(serviceOrderId: $serviceOrderId, status: $status, postingDate: $postingDate, serviceType: $serviceType, totalNetAmount: $totalNetAmount, outstandingAmount: $outstandingAmount, receivedAmount: $receivedAmount)';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "service_order_id") String? serviceOrderId,@JsonKey(name: "status") String? status,@JsonKey(name: "posting_date") String? postingDate,@JsonKey(name: "service_type") String? serviceType,@JsonKey(name: "total_net_amount") int? totalNetAmount,@JsonKey(name: "outstanding_amount") int? outstandingAmount,@JsonKey(name: "received_amount") int? receivedAmount
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceOrderId = freezed,Object? status = freezed,Object? postingDate = freezed,Object? serviceType = freezed,Object? totalNetAmount = freezed,Object? outstandingAmount = freezed,Object? receivedAmount = freezed,}) {
  return _then(_self.copyWith(
serviceOrderId: freezed == serviceOrderId ? _self.serviceOrderId : serviceOrderId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,postingDate: freezed == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,totalNetAmount: freezed == totalNetAmount ? _self.totalNetAmount : totalNetAmount // ignore: cast_nullable_to_non_nullable
as int?,outstandingAmount: freezed == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as int?,receivedAmount: freezed == receivedAmount ? _self.receivedAmount : receivedAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Order implements Order {
  const _Order({@JsonKey(name: "service_order_id") this.serviceOrderId, @JsonKey(name: "status") this.status, @JsonKey(name: "posting_date") this.postingDate, @JsonKey(name: "service_type") this.serviceType, @JsonKey(name: "total_net_amount") this.totalNetAmount, @JsonKey(name: "outstanding_amount") this.outstandingAmount, @JsonKey(name: "received_amount") this.receivedAmount});
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

@override@JsonKey(name: "service_order_id") final  String? serviceOrderId;
@override@JsonKey(name: "status") final  String? status;
@override@JsonKey(name: "posting_date") final  String? postingDate;
@override@JsonKey(name: "service_type") final  String? serviceType;
@override@JsonKey(name: "total_net_amount") final  int? totalNetAmount;
@override@JsonKey(name: "outstanding_amount") final  int? outstandingAmount;
@override@JsonKey(name: "received_amount") final  int? receivedAmount;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.serviceOrderId, serviceOrderId) || other.serviceOrderId == serviceOrderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.totalNetAmount, totalNetAmount) || other.totalNetAmount == totalNetAmount)&&(identical(other.outstandingAmount, outstandingAmount) || other.outstandingAmount == outstandingAmount)&&(identical(other.receivedAmount, receivedAmount) || other.receivedAmount == receivedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceOrderId,status,postingDate,serviceType,totalNetAmount,outstandingAmount,receivedAmount);

@override
String toString() {
  return 'Order(serviceOrderId: $serviceOrderId, status: $status, postingDate: $postingDate, serviceType: $serviceType, totalNetAmount: $totalNetAmount, outstandingAmount: $outstandingAmount, receivedAmount: $receivedAmount)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "service_order_id") String? serviceOrderId,@JsonKey(name: "status") String? status,@JsonKey(name: "posting_date") String? postingDate,@JsonKey(name: "service_type") String? serviceType,@JsonKey(name: "total_net_amount") int? totalNetAmount,@JsonKey(name: "outstanding_amount") int? outstandingAmount,@JsonKey(name: "received_amount") int? receivedAmount
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceOrderId = freezed,Object? status = freezed,Object? postingDate = freezed,Object? serviceType = freezed,Object? totalNetAmount = freezed,Object? outstandingAmount = freezed,Object? receivedAmount = freezed,}) {
  return _then(_Order(
serviceOrderId: freezed == serviceOrderId ? _self.serviceOrderId : serviceOrderId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,postingDate: freezed == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,totalNetAmount: freezed == totalNetAmount ? _self.totalNetAmount : totalNetAmount // ignore: cast_nullable_to_non_nullable
as int?,outstandingAmount: freezed == outstandingAmount ? _self.outstandingAmount : outstandingAmount // ignore: cast_nullable_to_non_nullable
as int?,receivedAmount: freezed == receivedAmount ? _self.receivedAmount : receivedAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Totals {

@JsonKey(name: "total_outstanding_amount") int? get totalOutstandingAmount;@JsonKey(name: "total_net_amount") int? get totalNetAmount;@JsonKey(name: "total_received_amount") int? get totalReceivedAmount;
/// Create a copy of Totals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TotalsCopyWith<Totals> get copyWith => _$TotalsCopyWithImpl<Totals>(this as Totals, _$identity);

  /// Serializes this Totals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Totals&&(identical(other.totalOutstandingAmount, totalOutstandingAmount) || other.totalOutstandingAmount == totalOutstandingAmount)&&(identical(other.totalNetAmount, totalNetAmount) || other.totalNetAmount == totalNetAmount)&&(identical(other.totalReceivedAmount, totalReceivedAmount) || other.totalReceivedAmount == totalReceivedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalOutstandingAmount,totalNetAmount,totalReceivedAmount);

@override
String toString() {
  return 'Totals(totalOutstandingAmount: $totalOutstandingAmount, totalNetAmount: $totalNetAmount, totalReceivedAmount: $totalReceivedAmount)';
}


}

/// @nodoc
abstract mixin class $TotalsCopyWith<$Res>  {
  factory $TotalsCopyWith(Totals value, $Res Function(Totals) _then) = _$TotalsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "total_outstanding_amount") int? totalOutstandingAmount,@JsonKey(name: "total_net_amount") int? totalNetAmount,@JsonKey(name: "total_received_amount") int? totalReceivedAmount
});




}
/// @nodoc
class _$TotalsCopyWithImpl<$Res>
    implements $TotalsCopyWith<$Res> {
  _$TotalsCopyWithImpl(this._self, this._then);

  final Totals _self;
  final $Res Function(Totals) _then;

/// Create a copy of Totals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalOutstandingAmount = freezed,Object? totalNetAmount = freezed,Object? totalReceivedAmount = freezed,}) {
  return _then(_self.copyWith(
totalOutstandingAmount: freezed == totalOutstandingAmount ? _self.totalOutstandingAmount : totalOutstandingAmount // ignore: cast_nullable_to_non_nullable
as int?,totalNetAmount: freezed == totalNetAmount ? _self.totalNetAmount : totalNetAmount // ignore: cast_nullable_to_non_nullable
as int?,totalReceivedAmount: freezed == totalReceivedAmount ? _self.totalReceivedAmount : totalReceivedAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Totals implements Totals {
  const _Totals({@JsonKey(name: "total_outstanding_amount") this.totalOutstandingAmount, @JsonKey(name: "total_net_amount") this.totalNetAmount, @JsonKey(name: "total_received_amount") this.totalReceivedAmount});
  factory _Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);

@override@JsonKey(name: "total_outstanding_amount") final  int? totalOutstandingAmount;
@override@JsonKey(name: "total_net_amount") final  int? totalNetAmount;
@override@JsonKey(name: "total_received_amount") final  int? totalReceivedAmount;

/// Create a copy of Totals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TotalsCopyWith<_Totals> get copyWith => __$TotalsCopyWithImpl<_Totals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Totals&&(identical(other.totalOutstandingAmount, totalOutstandingAmount) || other.totalOutstandingAmount == totalOutstandingAmount)&&(identical(other.totalNetAmount, totalNetAmount) || other.totalNetAmount == totalNetAmount)&&(identical(other.totalReceivedAmount, totalReceivedAmount) || other.totalReceivedAmount == totalReceivedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalOutstandingAmount,totalNetAmount,totalReceivedAmount);

@override
String toString() {
  return 'Totals(totalOutstandingAmount: $totalOutstandingAmount, totalNetAmount: $totalNetAmount, totalReceivedAmount: $totalReceivedAmount)';
}


}

/// @nodoc
abstract mixin class _$TotalsCopyWith<$Res> implements $TotalsCopyWith<$Res> {
  factory _$TotalsCopyWith(_Totals value, $Res Function(_Totals) _then) = __$TotalsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "total_outstanding_amount") int? totalOutstandingAmount,@JsonKey(name: "total_net_amount") int? totalNetAmount,@JsonKey(name: "total_received_amount") int? totalReceivedAmount
});




}
/// @nodoc
class __$TotalsCopyWithImpl<$Res>
    implements _$TotalsCopyWith<$Res> {
  __$TotalsCopyWithImpl(this._self, this._then);

  final _Totals _self;
  final $Res Function(_Totals) _then;

/// Create a copy of Totals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalOutstandingAmount = freezed,Object? totalNetAmount = freezed,Object? totalReceivedAmount = freezed,}) {
  return _then(_Totals(
totalOutstandingAmount: freezed == totalOutstandingAmount ? _self.totalOutstandingAmount : totalOutstandingAmount // ignore: cast_nullable_to_non_nullable
as int?,totalNetAmount: freezed == totalNetAmount ? _self.totalNetAmount : totalNetAmount // ignore: cast_nullable_to_non_nullable
as int?,totalReceivedAmount: freezed == totalReceivedAmount ? _self.totalReceivedAmount : totalReceivedAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
