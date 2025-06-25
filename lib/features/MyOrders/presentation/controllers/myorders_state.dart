import 'package:equatable/equatable.dart';
import 'package:hcs/features/MyOrders/data/models/orders_details_model.dart';
import 'package:hcs/features/MyOrders/data/models/services_orders_model.dart';

import 'package:hcs/src/enums/request_state.dart';

class MyOrdersState extends Equatable {
  //orders
  final int? currentServicesOrdersPage;
  final List<Orders> orders;
  final RequestStates ordersStates;
  final String? ordersMessage;

  //Orders Details
  final Details? ordersDetails;
  final RequestStates ordersDetailsStates;
  final String? ordersDetailsMessage;

  const MyOrdersState({
    //orders
    this.currentServicesOrdersPage,
    this.orders = const [],
    this.ordersStates = RequestStates.init,
    this.ordersMessage = '',

    //Orders Details
    this.ordersDetails,
    this.ordersDetailsStates = RequestStates.init,
    this.ordersDetailsMessage = '',
  });
  MyOrdersState copyWith({
    //orders
    int? currentServicesOrdersPage,
    List<Orders>? orders,
    RequestStates? ordersStates,
    String? ordersMessage,

    //Orders Details
    Details? ordersDetails,
    RequestStates? ordersDetailsStates,
    String? ordersDetailsMessage,
  }) {
    return MyOrdersState(
      //orders
      currentServicesOrdersPage: currentServicesOrdersPage,
      orders: orders ?? this.orders,
      ordersStates: ordersStates ?? this.ordersStates,
      ordersMessage: ordersMessage ?? this.ordersMessage,

      //Orders Details
      ordersDetails: ordersDetails ?? this.ordersDetails,
      ordersDetailsMessage: ordersDetailsMessage ?? this.ordersDetailsMessage,
      ordersDetailsStates: ordersDetailsStates ?? this.ordersDetailsStates,
    );
  }

  @override
  List<Object?> get props => [
    //orders
    currentServicesOrdersPage,
    orders,
    ordersStates,
    ordersMessage,

    //Orders Details
    ordersDetails, ordersDetailsMessage, ordersDetailsStates,
  ];
}
