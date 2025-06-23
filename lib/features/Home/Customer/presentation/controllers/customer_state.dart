import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class CustomerState extends Equatable {
  //customers
  final int? currentCustomersPage;
  final List<Customers> customers;
  final RequestStates customersStates;
  final String? customersMessage;
  final Customers? selectedCustomer;

  const CustomerState({
    //customers
    this.currentCustomersPage,
    this.customers = const [],
    this.customersStates = RequestStates.init,
    this.customersMessage = '',
    this.selectedCustomer,
  });
  CustomerState copyWith({
    //customers
    int? currentCustomersPage,
    List<Customers>? customers,
    RequestStates? customersStates,
    String? customersMessage,
    Customers? selectedCustomer,
  }) {
    return CustomerState(
      //customers
      currentCustomersPage: currentCustomersPage ?? this.currentCustomersPage,
      customers: customers ?? this.customers,
      customersStates: customersStates ?? this.customersStates,
      customersMessage: customersMessage ?? this.customersMessage,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
    );
  }

  @override
  List<Object?> get props => [
    //customers
    currentCustomersPage,
    customers,
    customersStates,
    customersMessage, selectedCustomer,
  ];
}
