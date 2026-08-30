// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_clean_order_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeepCleanOrderParams {

@JsonKey(name: 'customer_id') String get customerId;@JsonKey(name: 'service_ids') List<String> get serviceIds;@JsonKey(name: 'service_type') String get serviceType; String get shift; DateTime get date;
/// Create a copy of DeepCleanOrderParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepCleanOrderParamsCopyWith<DeepCleanOrderParams> get copyWith => _$DeepCleanOrderParamsCopyWithImpl<DeepCleanOrderParams>(this as DeepCleanOrderParams, _$identity);

  /// Serializes this DeepCleanOrderParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepCleanOrderParams&&(identical(other.customerId, customerId) || other.customerId == customerId)&&const DeepCollectionEquality().equals(other.serviceIds, serviceIds)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerId,const DeepCollectionEquality().hash(serviceIds),serviceType,shift,date);

@override
String toString() {
  return 'DeepCleanOrderParams(customerId: $customerId, serviceIds: $serviceIds, serviceType: $serviceType, shift: $shift, date: $date)';
}


}

/// @nodoc
abstract mixin class $DeepCleanOrderParamsCopyWith<$Res>  {
  factory $DeepCleanOrderParamsCopyWith(DeepCleanOrderParams value, $Res Function(DeepCleanOrderParams) _then) = _$DeepCleanOrderParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'customer_id') String customerId,@JsonKey(name: 'service_ids') List<String> serviceIds,@JsonKey(name: 'service_type') String serviceType, String shift, DateTime date
});




}
/// @nodoc
class _$DeepCleanOrderParamsCopyWithImpl<$Res>
    implements $DeepCleanOrderParamsCopyWith<$Res> {
  _$DeepCleanOrderParamsCopyWithImpl(this._self, this._then);

  final DeepCleanOrderParams _self;
  final $Res Function(DeepCleanOrderParams) _then;

/// Create a copy of DeepCleanOrderParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerId = null,Object? serviceIds = null,Object? serviceType = null,Object? shift = null,Object? date = null,}) {
  return _then(_self.copyWith(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,serviceIds: null == serviceIds ? _self.serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DeepCleanOrderParams implements DeepCleanOrderParams {
  const _DeepCleanOrderParams({@JsonKey(name: 'customer_id') required this.customerId, @JsonKey(name: 'service_ids') required final  List<String> serviceIds, @JsonKey(name: 'service_type') required this.serviceType, required this.shift, required this.date}): _serviceIds = serviceIds;
  factory _DeepCleanOrderParams.fromJson(Map<String, dynamic> json) => _$DeepCleanOrderParamsFromJson(json);

@override@JsonKey(name: 'customer_id') final  String customerId;
 final  List<String> _serviceIds;
@override@JsonKey(name: 'service_ids') List<String> get serviceIds {
  if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceIds);
}

@override@JsonKey(name: 'service_type') final  String serviceType;
@override final  String shift;
@override final  DateTime date;

/// Create a copy of DeepCleanOrderParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepCleanOrderParamsCopyWith<_DeepCleanOrderParams> get copyWith => __$DeepCleanOrderParamsCopyWithImpl<_DeepCleanOrderParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepCleanOrderParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepCleanOrderParams&&(identical(other.customerId, customerId) || other.customerId == customerId)&&const DeepCollectionEquality().equals(other._serviceIds, _serviceIds)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.shift, shift) || other.shift == shift)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerId,const DeepCollectionEquality().hash(_serviceIds),serviceType,shift,date);

@override
String toString() {
  return 'DeepCleanOrderParams(customerId: $customerId, serviceIds: $serviceIds, serviceType: $serviceType, shift: $shift, date: $date)';
}


}

/// @nodoc
abstract mixin class _$DeepCleanOrderParamsCopyWith<$Res> implements $DeepCleanOrderParamsCopyWith<$Res> {
  factory _$DeepCleanOrderParamsCopyWith(_DeepCleanOrderParams value, $Res Function(_DeepCleanOrderParams) _then) = __$DeepCleanOrderParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'customer_id') String customerId,@JsonKey(name: 'service_ids') List<String> serviceIds,@JsonKey(name: 'service_type') String serviceType, String shift, DateTime date
});




}
/// @nodoc
class __$DeepCleanOrderParamsCopyWithImpl<$Res>
    implements _$DeepCleanOrderParamsCopyWith<$Res> {
  __$DeepCleanOrderParamsCopyWithImpl(this._self, this._then);

  final _DeepCleanOrderParams _self;
  final $Res Function(_DeepCleanOrderParams) _then;

/// Create a copy of DeepCleanOrderParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? serviceIds = null,Object? serviceType = null,Object? shift = null,Object? date = null,}) {
  return _then(_DeepCleanOrderParams(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,serviceIds: null == serviceIds ? _self._serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<String>,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,shift: null == shift ? _self.shift : shift // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
