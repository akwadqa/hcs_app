// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_clean_service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeepCleanServiceModel {

 String get id; String get name; String? get subtitle;// e.g. "Apartment · Up to 100 m²"
 double? get price; List<ServiceField> get fields;
/// Create a copy of DeepCleanServiceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepCleanServiceModelCopyWith<DeepCleanServiceModel> get copyWith => _$DeepCleanServiceModelCopyWithImpl<DeepCleanServiceModel>(this as DeepCleanServiceModel, _$identity);

  /// Serializes this DeepCleanServiceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepCleanServiceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other.fields, fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,subtitle,price,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'DeepCleanServiceModel(id: $id, name: $name, subtitle: $subtitle, price: $price, fields: $fields)';
}


}

/// @nodoc
abstract mixin class $DeepCleanServiceModelCopyWith<$Res>  {
  factory $DeepCleanServiceModelCopyWith(DeepCleanServiceModel value, $Res Function(DeepCleanServiceModel) _then) = _$DeepCleanServiceModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? subtitle, double? price, List<ServiceField> fields
});




}
/// @nodoc
class _$DeepCleanServiceModelCopyWithImpl<$Res>
    implements $DeepCleanServiceModelCopyWith<$Res> {
  _$DeepCleanServiceModelCopyWithImpl(this._self, this._then);

  final DeepCleanServiceModel _self;
  final $Res Function(DeepCleanServiceModel) _then;

/// Create a copy of DeepCleanServiceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? subtitle = freezed,Object? price = freezed,Object? fields = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<ServiceField>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DeepCleanServiceModel implements DeepCleanServiceModel {
  const _DeepCleanServiceModel({required this.id, required this.name, this.subtitle, this.price, final  List<ServiceField> fields = const []}): _fields = fields;
  factory _DeepCleanServiceModel.fromJson(Map<String, dynamic> json) => _$DeepCleanServiceModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? subtitle;
// e.g. "Apartment · Up to 100 m²"
@override final  double? price;
 final  List<ServiceField> _fields;
@override@JsonKey() List<ServiceField> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}


/// Create a copy of DeepCleanServiceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepCleanServiceModelCopyWith<_DeepCleanServiceModel> get copyWith => __$DeepCleanServiceModelCopyWithImpl<_DeepCleanServiceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepCleanServiceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepCleanServiceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other._fields, _fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,subtitle,price,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'DeepCleanServiceModel(id: $id, name: $name, subtitle: $subtitle, price: $price, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$DeepCleanServiceModelCopyWith<$Res> implements $DeepCleanServiceModelCopyWith<$Res> {
  factory _$DeepCleanServiceModelCopyWith(_DeepCleanServiceModel value, $Res Function(_DeepCleanServiceModel) _then) = __$DeepCleanServiceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? subtitle, double? price, List<ServiceField> fields
});




}
/// @nodoc
class __$DeepCleanServiceModelCopyWithImpl<$Res>
    implements _$DeepCleanServiceModelCopyWith<$Res> {
  __$DeepCleanServiceModelCopyWithImpl(this._self, this._then);

  final _DeepCleanServiceModel _self;
  final $Res Function(_DeepCleanServiceModel) _then;

/// Create a copy of DeepCleanServiceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? subtitle = freezed,Object? price = freezed,Object? fields = null,}) {
  return _then(_DeepCleanServiceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<ServiceField>,
  ));
}


}

// dart format on
