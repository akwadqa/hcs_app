import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/customer_balance_model.dart';
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
  final bool withCleaningSupplies;
  //
  final RequestStates discountStates;
  final RequestStates customerBalanceState;
  final List<Discount> discountType;
  final Discount? selectedDiscount;
  final double? discountPercentage;
  final double originalCost;
  final double? discountedCost;
  final double? newCost;
  final double? costAfterCleaningSuplies;
  //
  final String note;
  final CustomerBalanceData? customerBalanceData;
  final bool isAdvancedBalance;
  final double? fees;
  const DriverPaymentState({
    //drivers
    this.currentDriversPage,
    this.drivers = const [],
    this.driversStates = RequestStates.init,
    this.driversMessage = '',
    this.selectedDriver,
    this.selectedPaymentMethod = 'SkipCash',
    this.withCleaningSupplies = false,
    //
    this.discountStates = RequestStates.init,
    this.selectedDiscount,
    this.discountType = const [],
    this.discountPercentage,
    this.originalCost = 0.0,
    this.discountedCost,
    this.costAfterCleaningSuplies = 0,
    this.newCost,
    this.fees,
    //
    this.note = '',
    this.customerBalanceData,
    this.customerBalanceState = RequestStates.init,
    this.isAdvancedBalance = false,
  });
  DriverPaymentState copyWith({
    //drivers
    int? currentDriversPage,
    List<Driver>? drivers,
    RequestStates? driversStates,
    RequestStates? customerBalanceState,
    String? driversMessage,
    Driver? selectedDriver,
    String? selectedPaymentMethod,
    bool? withCleaningSupplies,

    //
    RequestStates? discountStates,
    List<Discount>? discountType,
    Discount? selectedDiscount,
    double? discountPercentage,
    double? originalCost,
    double? discountedCost,
    double? newCost,
    double? costAfterCleaningSuplies,
    //
    String? note,
    CustomerBalanceData? customerBalanceData,
    bool? isAdvancedBalance,
    double? fees,
  }) {
    return DriverPaymentState(
      //drivers
      currentDriversPage: currentDriversPage,
      drivers: drivers ?? this.drivers,
      driversStates: driversStates ?? this.driversStates,
      driversMessage: driversMessage ?? this.driversMessage,
      selectedDriver: selectedDriver ?? this.selectedDriver,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      withCleaningSupplies: withCleaningSupplies ?? this.withCleaningSupplies,
      discountStates: discountStates ?? this.discountStates,
      discountType: discountType ?? this.discountType,
      selectedDiscount: selectedDiscount ?? this.selectedDiscount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      originalCost: originalCost ?? this.originalCost,
      discountedCost: discountedCost ?? this.discountedCost,
      note: note ?? this.note,
      newCost: newCost ?? this.newCost,
      costAfterCleaningSuplies:
          costAfterCleaningSuplies ?? this.costAfterCleaningSuplies,
      customerBalanceData: customerBalanceData ?? this.customerBalanceData,
      customerBalanceState: customerBalanceState ?? this.customerBalanceState,
      isAdvancedBalance: isAdvancedBalance ?? this.isAdvancedBalance,
      fees: fees ?? this.fees,
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
    selectedPaymentMethod, withCleaningSupplies,
    discountStates,
    discountType,
    selectedDiscount, discountPercentage,
    originalCost,
    newCost,
    costAfterCleaningSuplies,
    discountedCost, note,
    isAdvancedBalance, customerBalanceData, customerBalanceState, fees,
  ];
}
