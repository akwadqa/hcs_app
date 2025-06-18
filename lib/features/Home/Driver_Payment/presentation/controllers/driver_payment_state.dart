import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/discount_type.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class DriverPaymentState extends Equatable {
  //drivers
  final int? currentDriversPage;
  final List<Driver> drivers;
  final RequestStates driversStates;
  final String? driversMessage;
  final Driver? selectedDriver;
  final String selectedPaymentMethod;
  //
  final RequestStates discountStates;
  final List<Discount> discountType;
  final Discount? selectedDiscount;
  final double discountPercentage;
  final double originalCost;
  final double discountedCost;
  const DriverPaymentState({
    //drivers
    this.currentDriversPage,
    this.drivers = const [],
    this.driversStates = RequestStates.init,
    this.driversMessage = '',
    this.selectedDriver,
    this.selectedPaymentMethod = 'Link',
    //
    this.discountStates = RequestStates.init,
    this.selectedDiscount,
    this.discountType = const [],
    this.discountPercentage = 0.0,
    this.originalCost = 0.0,
    this.discountedCost = 0.0,
  });
  DriverPaymentState copyWith({
    //drivers
    int? currentDriversPage,
    List<Driver>? drivers,
    RequestStates? driversStates,
    String? driversMessage,
    Driver? selectedDriver,
    String? selectedPaymentMethod,

    //
    RequestStates? discountStates,
    List<Discount>? discountType,
    Discount? selectedDiscount,
    double? discountPercentage,
    double? originalCost,
    double? discountedCost,
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
      discountStates: discountStates ?? this.discountStates,
      discountType: discountType ?? this.discountType,
      selectedDiscount: selectedDiscount ?? this.selectedDiscount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      originalCost: originalCost ?? this.originalCost,
      discountedCost: discountedCost ?? this.discountedCost,
    );
  }

  @override
  List<Object?> get props => [
    //drivers
    currentDriversPage,
    drivers,
    driversStates,
    driversMessage,
    selectedDriver,
    selectedPaymentMethod,
    discountStates,
    discountType,
    selectedDiscount, discountPercentage,
    originalCost,
    discountedCost,
  ];
}
