// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_field_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldOption {

 String get id; String get label; double? get price;@JsonKey(name: 'is_quote') bool get isQuote;
/// Create a copy of FieldOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldOptionCopyWith<FieldOption> get copyWith => _$FieldOptionCopyWithImpl<FieldOption>(this as FieldOption, _$identity);

  /// Serializes this FieldOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.price, price) || other.price == price)&&(identical(other.isQuote, isQuote) || other.isQuote == isQuote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,price,isQuote);

@override
String toString() {
  return 'FieldOption(id: $id, label: $label, price: $price, isQuote: $isQuote)';
}


}

/// @nodoc
abstract mixin class $FieldOptionCopyWith<$Res>  {
  factory $FieldOptionCopyWith(FieldOption value, $Res Function(FieldOption) _then) = _$FieldOptionCopyWithImpl;
@useResult
$Res call({
 String id, String label, double? price,@JsonKey(name: 'is_quote') bool isQuote
});




}
/// @nodoc
class _$FieldOptionCopyWithImpl<$Res>
    implements $FieldOptionCopyWith<$Res> {
  _$FieldOptionCopyWithImpl(this._self, this._then);

  final FieldOption _self;
  final $Res Function(FieldOption) _then;

/// Create a copy of FieldOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? price = freezed,Object? isQuote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isQuote: null == isQuote ? _self.isQuote : isQuote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FieldOption implements FieldOption {
  const _FieldOption({required this.id, required this.label, this.price, @JsonKey(name: 'is_quote') this.isQuote = false});
  factory _FieldOption.fromJson(Map<String, dynamic> json) => _$FieldOptionFromJson(json);

@override final  String id;
@override final  String label;
@override final  double? price;
@override@JsonKey(name: 'is_quote') final  bool isQuote;

/// Create a copy of FieldOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldOptionCopyWith<_FieldOption> get copyWith => __$FieldOptionCopyWithImpl<_FieldOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.price, price) || other.price == price)&&(identical(other.isQuote, isQuote) || other.isQuote == isQuote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,price,isQuote);

@override
String toString() {
  return 'FieldOption(id: $id, label: $label, price: $price, isQuote: $isQuote)';
}


}

/// @nodoc
abstract mixin class _$FieldOptionCopyWith<$Res> implements $FieldOptionCopyWith<$Res> {
  factory _$FieldOptionCopyWith(_FieldOption value, $Res Function(_FieldOption) _then) = __$FieldOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, double? price,@JsonKey(name: 'is_quote') bool isQuote
});




}
/// @nodoc
class __$FieldOptionCopyWithImpl<$Res>
    implements _$FieldOptionCopyWith<$Res> {
  __$FieldOptionCopyWithImpl(this._self, this._then);

  final _FieldOption _self;
  final $Res Function(_FieldOption) _then;

/// Create a copy of FieldOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? price = freezed,Object? isQuote = null,}) {
  return _then(_FieldOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isQuote: null == isQuote ? _self.isQuote : isQuote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ServiceField {

 String get key; String get label; FieldType get type; bool get required; String? get hint; List<FieldOption> get options;@JsonKey(name: 'depends_on') String? get dependsOn;@JsonKey(name: 'options_by_parent') Map<String, List<FieldOption>>? get optionsByParent;
/// Create a copy of ServiceField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceFieldCopyWith<ServiceField> get copyWith => _$ServiceFieldCopyWithImpl<ServiceField>(this as ServiceField, _$identity);

  /// Serializes this ServiceField to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceField&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.required, required) || other.required == required)&&(identical(other.hint, hint) || other.hint == hint)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.dependsOn, dependsOn) || other.dependsOn == dependsOn)&&const DeepCollectionEquality().equals(other.optionsByParent, optionsByParent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,type,required,hint,const DeepCollectionEquality().hash(options),dependsOn,const DeepCollectionEquality().hash(optionsByParent));

@override
String toString() {
  return 'ServiceField(key: $key, label: $label, type: $type, required: $required, hint: $hint, options: $options, dependsOn: $dependsOn, optionsByParent: $optionsByParent)';
}


}

/// @nodoc
abstract mixin class $ServiceFieldCopyWith<$Res>  {
  factory $ServiceFieldCopyWith(ServiceField value, $Res Function(ServiceField) _then) = _$ServiceFieldCopyWithImpl;
@useResult
$Res call({
 String key, String label, FieldType type, bool required, String? hint, List<FieldOption> options,@JsonKey(name: 'depends_on') String? dependsOn,@JsonKey(name: 'options_by_parent') Map<String, List<FieldOption>>? optionsByParent
});




}
/// @nodoc
class _$ServiceFieldCopyWithImpl<$Res>
    implements $ServiceFieldCopyWith<$Res> {
  _$ServiceFieldCopyWithImpl(this._self, this._then);

  final ServiceField _self;
  final $Res Function(ServiceField) _then;

/// Create a copy of ServiceField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? type = null,Object? required = null,Object? hint = freezed,Object? options = null,Object? dependsOn = freezed,Object? optionsByParent = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FieldType,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<FieldOption>,dependsOn: freezed == dependsOn ? _self.dependsOn : dependsOn // ignore: cast_nullable_to_non_nullable
as String?,optionsByParent: freezed == optionsByParent ? _self.optionsByParent : optionsByParent // ignore: cast_nullable_to_non_nullable
as Map<String, List<FieldOption>>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ServiceField implements ServiceField {
  const _ServiceField({required this.key, required this.label, this.type = FieldType.text, this.required = true, this.hint, final  List<FieldOption> options = const [], @JsonKey(name: 'depends_on') this.dependsOn, @JsonKey(name: 'options_by_parent') final  Map<String, List<FieldOption>>? optionsByParent}): _options = options,_optionsByParent = optionsByParent;
  factory _ServiceField.fromJson(Map<String, dynamic> json) => _$ServiceFieldFromJson(json);

@override final  String key;
@override final  String label;
@override@JsonKey() final  FieldType type;
@override@JsonKey() final  bool required;
@override final  String? hint;
 final  List<FieldOption> _options;
@override@JsonKey() List<FieldOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override@JsonKey(name: 'depends_on') final  String? dependsOn;
 final  Map<String, List<FieldOption>>? _optionsByParent;
@override@JsonKey(name: 'options_by_parent') Map<String, List<FieldOption>>? get optionsByParent {
  final value = _optionsByParent;
  if (value == null) return null;
  if (_optionsByParent is EqualUnmodifiableMapView) return _optionsByParent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ServiceField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceFieldCopyWith<_ServiceField> get copyWith => __$ServiceFieldCopyWithImpl<_ServiceField>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceFieldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceField&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.required, required) || other.required == required)&&(identical(other.hint, hint) || other.hint == hint)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.dependsOn, dependsOn) || other.dependsOn == dependsOn)&&const DeepCollectionEquality().equals(other._optionsByParent, _optionsByParent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,type,required,hint,const DeepCollectionEquality().hash(_options),dependsOn,const DeepCollectionEquality().hash(_optionsByParent));

@override
String toString() {
  return 'ServiceField(key: $key, label: $label, type: $type, required: $required, hint: $hint, options: $options, dependsOn: $dependsOn, optionsByParent: $optionsByParent)';
}


}

/// @nodoc
abstract mixin class _$ServiceFieldCopyWith<$Res> implements $ServiceFieldCopyWith<$Res> {
  factory _$ServiceFieldCopyWith(_ServiceField value, $Res Function(_ServiceField) _then) = __$ServiceFieldCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, FieldType type, bool required, String? hint, List<FieldOption> options,@JsonKey(name: 'depends_on') String? dependsOn,@JsonKey(name: 'options_by_parent') Map<String, List<FieldOption>>? optionsByParent
});




}
/// @nodoc
class __$ServiceFieldCopyWithImpl<$Res>
    implements _$ServiceFieldCopyWith<$Res> {
  __$ServiceFieldCopyWithImpl(this._self, this._then);

  final _ServiceField _self;
  final $Res Function(_ServiceField) _then;

/// Create a copy of ServiceField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? type = null,Object? required = null,Object? hint = freezed,Object? options = null,Object? dependsOn = freezed,Object? optionsByParent = freezed,}) {
  return _then(_ServiceField(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FieldType,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<FieldOption>,dependsOn: freezed == dependsOn ? _self.dependsOn : dependsOn // ignore: cast_nullable_to_non_nullable
as String?,optionsByParent: freezed == optionsByParent ? _self._optionsByParent : optionsByParent // ignore: cast_nullable_to_non_nullable
as Map<String, List<FieldOption>>?,
  ));
}


}

// dart format on
