import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class DriverPaymentState extends Equatable {
  //drivers
  final int? currentDriversPage;
  final List<Driver> drivers;
  final RequestStates driversStates;
  final String? driversMessage;
  final Driver? selectedDriver;
  final String? selectedPaymentMethod;

  const DriverPaymentState({
    //drivers
    this.currentDriversPage,
    this.drivers = const [],
    this.driversStates = RequestStates.init,
    this.driversMessage = '',
    this.selectedDriver,
    this.selectedPaymentMethod,
  });
  DriverPaymentState copyWith({
    //drivers
    int? currentDriversPage,
    List<Driver>? drivers,
    RequestStates? driversStates,
    String? driversMessage,
    Driver? selectedDriver,
    String? selectedPaymentMethod,
  }) {
    return DriverPaymentState(
      //drivers
      currentDriversPage: currentDriversPage ?? this.currentDriversPage,
      drivers: drivers ?? this.drivers,
      driversStates: driversStates ?? this.driversStates,
      driversMessage: driversMessage ?? this.driversMessage,
      selectedDriver: selectedDriver ?? this.selectedDriver,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    //drivers
    currentDriversPage,
    drivers,
    driversStates,
    driversMessage, selectedDriver, selectedPaymentMethod,
  ];
}
