// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceItemModel {

@JsonKey(name: 'item_code') String get itemCode;@JsonKey(name: 'item_name') String get itemName; double? get rate;
/// Create a copy of ServiceItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceItemModelCopyWith<ServiceItemModel> get copyWith => _$ServiceItemModelCopyWithImpl<ServiceItemModel>(this as ServiceItemModel, _$identity);

  /// Serializes this ServiceItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceItemModel&&(identical(other.itemCode, itemCode) || other.itemCode == itemCode)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemCode,itemName,rate);

@override
String toString() {
  return 'ServiceItemModel(itemCode: $itemCode, itemName: $itemName, rate: $rate)';
}


}

/// @nodoc
abstract mixin class $ServiceItemModelCopyWith<$Res>  {
  factory $ServiceItemModelCopyWith(ServiceItemModel value, $Res Function(ServiceItemModel) _then) = _$ServiceItemModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'item_code') String itemCode,@JsonKey(name: 'item_name') String itemName, double? rate
});




}
/// @nodoc
class _$ServiceItemModelCopyWithImpl<$Res>
    implements $ServiceItemModelCopyWith<$Res> {
  _$ServiceItemModelCopyWithImpl(this._self, this._then);

  final ServiceItemModel _self;
  final $Res Function(ServiceItemModel) _then;

/// Create a copy of ServiceItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemCode = null,Object? itemName = null,Object? rate = freezed,}) {
  return _then(_self.copyWith(
itemCode: null == itemCode ? _self.itemCode : itemCode // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceItemModel implements ServiceItemModel {
  const _ServiceItemModel({@JsonKey(name: 'item_code') required this.itemCode, @JsonKey(name: 'item_name') required this.itemName, this.rate});
  factory _ServiceItemModel.fromJson(Map<String, dynamic> json) => _$ServiceItemModelFromJson(json);

@override@JsonKey(name: 'item_code') final  String itemCode;
@override@JsonKey(name: 'item_name') final  String itemName;
@override final  double? rate;

/// Create a copy of ServiceItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceItemModelCopyWith<_ServiceItemModel> get copyWith => __$ServiceItemModelCopyWithImpl<_ServiceItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceItemModel&&(identical(other.itemCode, itemCode) || other.itemCode == itemCode)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemCode,itemName,rate);

@override
String toString() {
  return 'ServiceItemModel(itemCode: $itemCode, itemName: $itemName, rate: $rate)';
}


}

/// @nodoc
abstract mixin class _$ServiceItemModelCopyWith<$Res> implements $ServiceItemModelCopyWith<$Res> {
  factory _$ServiceItemModelCopyWith(_ServiceItemModel value, $Res Function(_ServiceItemModel) _then) = __$ServiceItemModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'item_code') String itemCode,@JsonKey(name: 'item_name') String itemName, double? rate
});




}
/// @nodoc
class __$ServiceItemModelCopyWithImpl<$Res>
    implements _$ServiceItemModelCopyWith<$Res> {
  __$ServiceItemModelCopyWithImpl(this._self, this._then);

  final _ServiceItemModel _self;
  final $Res Function(_ServiceItemModel) _then;

/// Create a copy of ServiceItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemCode = null,Object? itemName = null,Object? rate = freezed,}) {
  return _then(_ServiceItemModel(
itemCode: null == itemCode ? _self.itemCode : itemCode // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
