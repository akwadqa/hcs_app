import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';

import 'package:hcs/src/enums/request_state.dart';

class MyOrdersState extends Equatable {
  //customers
  final int? currentCustomersPage;
  final List<Customers> customers;
  final RequestStates customersStates;
  final String? customersMessage;

  const MyOrdersState({
    //customers
    required this.currentCustomersPage,
    required this.customers,
    required this.customersStates,
    required this.customersMessage,
  });
  MyOrdersState copyWith({
    //customers
    int? currentCustomersPage,
    List<Customers>? customers,
    RequestStates? customersStates,
    String? customersMessage,
  }) {
    return MyOrdersState(
      //customers
      currentCustomersPage: currentCustomersPage ?? this.currentCustomersPage,
      customers: customers ?? this.customers,
      customersStates: customersStates ?? this.customersStates,
      customersMessage: customersMessage ?? this.customersMessage,
    );
  }

  @override
  List<Object?> get props => [
    //customers
    currentCustomersPage,
    customers,
    customersStates,
    customersMessage,
  ];
}
