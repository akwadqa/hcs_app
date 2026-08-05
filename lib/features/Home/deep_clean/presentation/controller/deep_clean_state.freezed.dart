// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_clean_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeepCleanState {

 HomeServiceMode get mode;// step 1 fetch
 RequestStates get servicesState; String get servicesError; List<ServiceItemModel> get services;// step 1 selections
 DeepCleanServiceType? get selectedServiceType; DeepCleanShift? get selectedShift; DateTime? get selectedDate;// step 2 : cards. `null` = empty card
 List<ServiceItemModel?> get selectedServices; Map<String, int> get quantities;
/// Create a copy of DeepCleanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepCleanStateCopyWith<DeepCleanState> get copyWith => _$DeepCleanStateCopyWithImpl<DeepCleanState>(this as DeepCleanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepCleanState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.servicesState, servicesState) || other.servicesState == servicesState)&&(identical(other.servicesError, servicesError) || other.servicesError == servicesError)&&const DeepCollectionEquality().equals(other.services, services)&&(identical(other.selectedServiceType, selectedServiceType) || other.selectedServiceType == selectedServiceType)&&(identical(other.selectedShift, selectedShift) || other.selectedShift == selectedShift)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other.selectedServices, selectedServices)&&const DeepCollectionEquality().equals(other.quantities, quantities));
}


@override
int get hashCode => Object.hash(runtimeType,mode,servicesState,servicesError,const DeepCollectionEquality().hash(services),selectedServiceType,selectedShift,selectedDate,const DeepCollectionEquality().hash(selectedServices),const DeepCollectionEquality().hash(quantities));

@override
String toString() {
  return 'DeepCleanState(mode: $mode, servicesState: $servicesState, servicesError: $servicesError, services: $services, selectedServiceType: $selectedServiceType, selectedShift: $selectedShift, selectedDate: $selectedDate, selectedServices: $selectedServices, quantities: $quantities)';
}


}

/// @nodoc
abstract mixin class $DeepCleanStateCopyWith<$Res>  {
  factory $DeepCleanStateCopyWith(DeepCleanState value, $Res Function(DeepCleanState) _then) = _$DeepCleanStateCopyWithImpl;
@useResult
$Res call({
 HomeServiceMode mode, RequestStates servicesState, String servicesError, List<ServiceItemModel> services, DeepCleanServiceType? selectedServiceType, DeepCleanShift? selectedShift, DateTime? selectedDate, List<ServiceItemModel?> selectedServices, Map<String, int> quantities
});




}
/// @nodoc
class _$DeepCleanStateCopyWithImpl<$Res>
    implements $DeepCleanStateCopyWith<$Res> {
  _$DeepCleanStateCopyWithImpl(this._self, this._then);

  final DeepCleanState _self;
  final $Res Function(DeepCleanState) _then;

/// Create a copy of DeepCleanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? servicesState = null,Object? servicesError = null,Object? services = null,Object? selectedServiceType = freezed,Object? selectedShift = freezed,Object? selectedDate = freezed,Object? selectedServices = null,Object? quantities = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as HomeServiceMode,servicesState: null == servicesState ? _self.servicesState : servicesState // ignore: cast_nullable_to_non_nullable
as RequestStates,servicesError: null == servicesError ? _self.servicesError : servicesError // ignore: cast_nullable_to_non_nullable
as String,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<ServiceItemModel>,selectedServiceType: freezed == selectedServiceType ? _self.selectedServiceType : selectedServiceType // ignore: cast_nullable_to_non_nullable
as DeepCleanServiceType?,selectedShift: freezed == selectedShift ? _self.selectedShift : selectedShift // ignore: cast_nullable_to_non_nullable
as DeepCleanShift?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedServices: null == selectedServices ? _self.selectedServices : selectedServices // ignore: cast_nullable_to_non_nullable
as List<ServiceItemModel?>,quantities: null == quantities ? _self.quantities : quantities // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// @nodoc


class _DeepCleanState extends DeepCleanState {
  const _DeepCleanState({this.mode = HomeServiceMode.deepClean, this.servicesState = RequestStates.initial, this.servicesError = '', final  List<ServiceItemModel> services = const [], this.selectedServiceType, this.selectedShift = DeepCleanShift.morning, this.selectedDate, final  List<ServiceItemModel?> selectedServices = const [null], final  Map<String, int> quantities = const {}}): _services = services,_selectedServices = selectedServices,_quantities = quantities,super._();
  

@override@JsonKey() final  HomeServiceMode mode;
// step 1 fetch
@override@JsonKey() final  RequestStates servicesState;
@override@JsonKey() final  String servicesError;
 final  List<ServiceItemModel> _services;
@override@JsonKey() List<ServiceItemModel> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

// step 1 selections
@override final  DeepCleanServiceType? selectedServiceType;
@override@JsonKey() final  DeepCleanShift? selectedShift;
@override final  DateTime? selectedDate;
// step 2 : cards. `null` = empty card
 final  List<ServiceItemModel?> _selectedServices;
// step 2 : cards. `null` = empty card
@override@JsonKey() List<ServiceItemModel?> get selectedServices {
  if (_selectedServices is EqualUnmodifiableListView) return _selectedServices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedServices);
}

 final  Map<String, int> _quantities;
@override@JsonKey() Map<String, int> get quantities {
  if (_quantities is EqualUnmodifiableMapView) return _quantities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_quantities);
}


/// Create a copy of DeepCleanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepCleanStateCopyWith<_DeepCleanState> get copyWith => __$DeepCleanStateCopyWithImpl<_DeepCleanState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepCleanState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.servicesState, servicesState) || other.servicesState == servicesState)&&(identical(other.servicesError, servicesError) || other.servicesError == servicesError)&&const DeepCollectionEquality().equals(other._services, _services)&&(identical(other.selectedServiceType, selectedServiceType) || other.selectedServiceType == selectedServiceType)&&(identical(other.selectedShift, selectedShift) || other.selectedShift == selectedShift)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other._selectedServices, _selectedServices)&&const DeepCollectionEquality().equals(other._quantities, _quantities));
}


@override
int get hashCode => Object.hash(runtimeType,mode,servicesState,servicesError,const DeepCollectionEquality().hash(_services),selectedServiceType,selectedShift,selectedDate,const DeepCollectionEquality().hash(_selectedServices),const DeepCollectionEquality().hash(_quantities));

@override
String toString() {
  return 'DeepCleanState(mode: $mode, servicesState: $servicesState, servicesError: $servicesError, services: $services, selectedServiceType: $selectedServiceType, selectedShift: $selectedShift, selectedDate: $selectedDate, selectedServices: $selectedServices, quantities: $quantities)';
}


}

/// @nodoc
abstract mixin class _$DeepCleanStateCopyWith<$Res> implements $DeepCleanStateCopyWith<$Res> {
  factory _$DeepCleanStateCopyWith(_DeepCleanState value, $Res Function(_DeepCleanState) _then) = __$DeepCleanStateCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceMode mode, RequestStates servicesState, String servicesError, List<ServiceItemModel> services, DeepCleanServiceType? selectedServiceType, DeepCleanShift? selectedShift, DateTime? selectedDate, List<ServiceItemModel?> selectedServices, Map<String, int> quantities
});




}
/// @nodoc
class __$DeepCleanStateCopyWithImpl<$Res>
    implements _$DeepCleanStateCopyWith<$Res> {
  __$DeepCleanStateCopyWithImpl(this._self, this._then);

  final _DeepCleanState _self;
  final $Res Function(_DeepCleanState) _then;

/// Create a copy of DeepCleanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? servicesState = null,Object? servicesError = null,Object? services = null,Object? selectedServiceType = freezed,Object? selectedShift = freezed,Object? selectedDate = freezed,Object? selectedServices = null,Object? quantities = null,}) {
  return _then(_DeepCleanState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as HomeServiceMode,servicesState: null == servicesState ? _self.servicesState : servicesState // ignore: cast_nullable_to_non_nullable
as RequestStates,servicesError: null == servicesError ? _self.servicesError : servicesError // ignore: cast_nullable_to_non_nullable
as String,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<ServiceItemModel>,selectedServiceType: freezed == selectedServiceType ? _self.selectedServiceType : selectedServiceType // ignore: cast_nullable_to_non_nullable
as DeepCleanServiceType?,selectedShift: freezed == selectedShift ? _self.selectedShift : selectedShift // ignore: cast_nullable_to_non_nullable
as DeepCleanShift?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedServices: null == selectedServices ? _self._selectedServices : selectedServices // ignore: cast_nullable_to_non_nullable
as List<ServiceItemModel?>,quantities: null == quantities ? _self._quantities : quantities // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
