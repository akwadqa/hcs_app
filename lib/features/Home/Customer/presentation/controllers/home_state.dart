import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class HomeState extends Equatable {
  //customers
  final int? currentCustomersPage;
  final List<Customers> customers;
  final RequestStates customersStates;
  final String? customersMessage;
  final Customers? selectedCustomer;

  const HomeState({
    //customers
    required this.currentCustomersPage,
    required this.customers,
    required this.customersStates,
    required this.customersMessage,
    required this.selectedCustomer,
  });
  HomeState copyWith({
    //customers
    int? currentCustomersPage,
    List<Customers>? customers,
    RequestStates? customersStates,
    String? customersMessage,
    Customers? selectedCustomer,
  }) {
    return HomeState(
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
