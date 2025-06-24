import 'package:equatable/equatable.dart';
import 'package:hcs/features/MyOrders/data/models/services_orders_model.dart';

import 'package:hcs/src/enums/request_state.dart';

class MyOrdersState extends Equatable {
  //orders
  final int? currentServicesOrdersPage;
  final List<Orders> orders;
  final RequestStates ordersStates;
  final String? ordersMessage;

  const MyOrdersState({
    //orders
    this.currentServicesOrdersPage,
    this.orders = const [],
    this.ordersStates = RequestStates.init,
    this.ordersMessage = '',
  });
  MyOrdersState copyWith({
    //orders
    int? currentServicesOrdersPage,
    List<Orders>? orders,
    RequestStates? ordersStates,
    String? ordersMessage,
  }) {
    return MyOrdersState(
      //orders
      currentServicesOrdersPage: currentServicesOrdersPage,
      orders: orders ?? this.orders,
      ordersStates: ordersStates ?? this.ordersStates,
      ordersMessage: ordersMessage ?? this.ordersMessage,
    );
  }

  @override
  List<Object?> get props => [
    //orders
    currentServicesOrdersPage,
    orders,
    ordersStates,
    ordersMessage,
  ];
}
