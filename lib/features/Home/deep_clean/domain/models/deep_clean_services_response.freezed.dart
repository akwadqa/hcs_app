// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_clean_services_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeepCleanServicesResponse {

 List<DeepCleanServiceModel> get data;
/// Create a copy of DeepCleanServicesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepCleanServicesResponseCopyWith<DeepCleanServicesResponse> get copyWith => _$DeepCleanServicesResponseCopyWithImpl<DeepCleanServicesResponse>(this as DeepCleanServicesResponse, _$identity);

  /// Serializes this DeepCleanServicesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepCleanServicesResponse&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'DeepCleanServicesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class $DeepCleanServicesResponseCopyWith<$Res>  {
  factory $DeepCleanServicesResponseCopyWith(DeepCleanServicesResponse value, $Res Function(DeepCleanServicesResponse) _then) = _$DeepCleanServicesResponseCopyWithImpl;
@useResult
$Res call({
 List<DeepCleanServiceModel> data
});




}
/// @nodoc
class _$DeepCleanServicesResponseCopyWithImpl<$Res>
    implements $DeepCleanServicesResponseCopyWith<$Res> {
  _$DeepCleanServicesResponseCopyWithImpl(this._self, this._then);

  final DeepCleanServicesResponse _self;
  final $Res Function(DeepCleanServicesResponse) _then;

/// Create a copy of DeepCleanServicesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<DeepCleanServiceModel>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DeepCleanServicesResponse implements DeepCleanServicesResponse {
  const _DeepCleanServicesResponse({final  List<DeepCleanServiceModel> data = const []}): _data = data;
  factory _DeepCleanServicesResponse.fromJson(Map<String, dynamic> json) => _$DeepCleanServicesResponseFromJson(json);

 final  List<DeepCleanServiceModel> _data;
@override@JsonKey() List<DeepCleanServiceModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of DeepCleanServicesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepCleanServicesResponseCopyWith<_DeepCleanServicesResponse> get copyWith => __$DeepCleanServicesResponseCopyWithImpl<_DeepCleanServicesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepCleanServicesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepCleanServicesResponse&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'DeepCleanServicesResponse(data: $data)';
}


}

/// @nodoc
abstract mixin class _$DeepCleanServicesResponseCopyWith<$Res> implements $DeepCleanServicesResponseCopyWith<$Res> {
  factory _$DeepCleanServicesResponseCopyWith(_DeepCleanServicesResponse value, $Res Function(_DeepCleanServicesResponse) _then) = __$DeepCleanServicesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<DeepCleanServiceModel> data
});




}
/// @nodoc
class __$DeepCleanServicesResponseCopyWithImpl<$Res>
    implements _$DeepCleanServicesResponseCopyWith<$Res> {
  __$DeepCleanServicesResponseCopyWithImpl(this._self, this._then);

  final _DeepCleanServicesResponse _self;
  final $Res Function(_DeepCleanServicesResponse) _then;

/// Create a copy of DeepCleanServicesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_DeepCleanServicesResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<DeepCleanServiceModel>,
  ));
}


}

// dart format on
