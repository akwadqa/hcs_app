import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/data/models/credits_model.dart';
import 'package:hcs/features/Home/data/models/home_block_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class MyOrdersState extends Equatable {
  final HomeBlockModel? homeBlock;
  final RequestStates myOrdersStates;
  final String? homeMessage;

  //credits

  final int? currentPage;
  final List<Datum> credits;
  final RequestStates creditsStates;
  final String? creditsMessage;

  const MyOrdersState({
    required this.homeBlock,
    required this.myOrdersStates,
    required this.homeMessage,

    //credits
    required this.currentPage,
    required this.credits,
    required this.creditsStates,
    required this.creditsMessage,
  });
  MyOrdersState copyWith({
    HomeBlockModel? homeBlock,
    RequestStates? myOrdersStates,
    String? homeMessage,

    //credits
    int? currentPage,
    List<Datum>? credits,
    RequestStates? creditsStates,
    String? creditsMessage,
  }) {
    return MyOrdersState(
      homeBlock: homeBlock ?? this.homeBlock,
      myOrdersStates: myOrdersStates ?? this.myOrdersStates,
      homeMessage: homeMessage ?? this.homeMessage,

      //credits
      currentPage: currentPage ?? this.currentPage,
      credits: credits ?? this.credits,
      creditsStates: creditsStates ?? this.creditsStates,
      creditsMessage: creditsMessage ?? this.creditsMessage,
    );
  }

  @override
  List<Object?> get props => [
    homeBlock,
    myOrdersStates,
    homeMessage,

    //credits
    currentPage,
    credits,
    creditsStates,
    creditsMessage,
  ];
}
