import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/data/models/credits_model.dart';
import 'package:hcs/features/Home/data/models/home_block_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class HomeState extends Equatable {
  final HomeBlockModel? homeBlock;
  final RequestStates homeStates;
  final String? homeMessage;

  //credits

  final int? currentPage;
  final List<Datum> credits;
  final RequestStates creditsStates;
  final String? creditsMessage;

  const HomeState({
    required this.homeBlock,
    required this.homeStates,
    required this.homeMessage,

    //credits
    required this.currentPage,
    required this.credits,
    required this.creditsStates,
    required this.creditsMessage,
  });
  HomeState copyWith({
    HomeBlockModel? homeBlock,
    RequestStates? homeStates,
    String? homeMessage,

    //credits
    int? currentPage,
    List<Datum>? credits,
    RequestStates? creditsStates,
    String? creditsMessage,
  }) {
    return HomeState(
      homeBlock: homeBlock ?? this.homeBlock,
      homeStates: homeStates ?? this.homeStates,
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
    homeStates,
    homeMessage,

    //credits
    currentPage,
    credits,
    creditsStates,
    creditsMessage,
  ];
}
