// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Define the state class representing the multi-step form
// class ServiceOrderState {
//   final Customer? selectedCustomer;
//   final Shift? selectedShift;
//   final List<Worker> selectedWorkers;
//   final Driver? selectedDriver;
//   final PaymentMethod? selectedPaymentMethod;

//   ServiceOrderState({
//     this.selectedCustomer,
//     this.selectedShift,
//     this.selectedWorkers = const [],
//     this.selectedDriver,
//     this.selectedPaymentMethod,
//   });

//   ServiceOrderState copyWith({
//     Customer? selectedCustomer,
//     Shift? selectedShift,
//     List<Worker>? selectedWorkers,
//     Driver? selectedDriver,
//     PaymentMethod? selectedPaymentMethod,
//   }) {
//     return ServiceOrderState(
//       selectedCustomer: selectedCustomer ?? this.selectedCustomer,
//       selectedShift: selectedShift ?? this.selectedShift,
//       selectedWorkers: selectedWorkers ?? this.selectedWorkers,
//       selectedDriver: selectedDriver ?? this.selectedDriver,
//       selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
//     );
//   }
// }

// // StateNotifier to manage updates
// class ServiceOrderNotifier extends StateNotifier<ServiceOrderState> {
//   ServiceOrderNotifier() : super(ServiceOrderState());

//   void setCustomer(Customer customer) {
//     state = state.copyWith(selectedCustomer: customer);
//   }

//   void setShift(Shift shift) {
//     state = state.copyWith(selectedShift: shift);
//   }

//   void setWorkers(List<Worker> workers) {
//     state = state.copyWith(selectedWorkers: workers);
//   }

//   void setDriver(Driver driver) {
//     state = state.copyWith(selectedDriver: driver);
//   }

//   void setPaymentMethod(PaymentMethod payment) {
//     state = state.copyWith(selectedPaymentMethod: payment);
//   }

//   void reset() {
//     state = ServiceOrderState();
//   }
// }

// // Provider to expose the notifier
// final serviceOrderProvider =
//     StateNotifierProvider<ServiceOrderNotifier, ServiceOrderState>((ref) {
//   return ServiceOrderNotifier();
// });
