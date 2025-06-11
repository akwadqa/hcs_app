import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Availability/data/models/packages_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class ServiceConfigState extends Equatable {
  //service config
  final String? selectedServiceType;
  final String? selectedShiftType;
  final PackagesData? selectedPackage;
  final String? selectedDate;
  final List<PackagesData> packages;
  final RequestStates packagesStates;
  final String? packagesMessage;

  const ServiceConfigState({
    //service config
    this.selectedServiceType,
    this.selectedShiftType = 'Morning',
    this.selectedPackage,
    this.selectedDate,

    this.packages = const [],
    this.packagesStates = RequestStates.init,
    this.packagesMessage = '',
  });
  ServiceConfigState copyWith({
    //customers
    String? selectedServiceType,
    String? selectedShiftType,
    PackagesData? selectedPackage,
    String? selectedDate,
    List<PackagesData>? packages,
    RequestStates? packagesStates,
    String? packagesMessage,
  }) {
    return ServiceConfigState(
      //service config
      selectedServiceType: selectedServiceType ?? this.selectedServiceType,
      selectedShiftType: selectedShiftType ?? this.selectedShiftType,
      selectedPackage: selectedPackage ?? this.selectedPackage,
      selectedDate: selectedDate ?? this.selectedDate,
      packages: packages ?? this.packages,
      packagesStates: packagesStates ?? this.packagesStates,
      packagesMessage: packagesMessage ?? this.packagesMessage,
    );
  }

  @override
  List<Object?> get props => [
    //service config
    selectedServiceType,
    selectedShiftType,
    selectedPackage,
    selectedDate,
    packages,
    packagesStates,
  ];
}
