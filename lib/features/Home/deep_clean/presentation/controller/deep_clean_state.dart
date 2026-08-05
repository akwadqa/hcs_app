import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/deep_clean_service_model.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';

import '../../domain/models/service_item_model.dart';

part 'deep_clean_state.freezed.dart';

enum DeepCleanShift {
  morning('Morning'),
  evening('Evening');

  final String label;
  const DeepCleanShift(this.label);
}

enum DeepCleanServiceType {
  onCall('On Call'),
  scheduled('Scheduled');

  final String label;
  const DeepCleanServiceType(this.label);
}

@freezed
abstract class DeepCleanState with _$DeepCleanState {
  const DeepCleanState._();

  const factory DeepCleanState({
    @Default(HomeServiceMode.deepClean) HomeServiceMode mode,

    // step 1 fetch
    @Default(RequestStates.initial) RequestStates servicesState,
    @Default('') String servicesError,
    @Default([]) List<ServiceItemModel> services,

    // step 1 selections
    DeepCleanServiceType? selectedServiceType,
    @Default(DeepCleanShift.morning) DeepCleanShift? selectedShift,
    DateTime? selectedDate,

    // step 2 : cards. `null` = empty card
    @Default([null]) List<ServiceItemModel?> selectedServices,
    @Default({}) Map<String, int> quantities,
  }) = _DeepCleanState;

  bool get isFirstStepValid =>
      // selectedServiceType != null &&
      selectedShift != null && selectedDate != null;

  /// Next enabled only if at least ONE card has a selection.
  bool get canGoToSummary => selectedServices.any((s) => s != null);

  List<ServiceItemModel> get chosenServices =>
      selectedServices.whereType<ServiceItemModel>().toList();
  int qtyFor(String itemCode) => quantities[itemCode] ?? 1;

  double get subtotal => chosenServices.fold(
        0.0,
        (sum, s) => sum + ((s.rate ?? 0) * qtyFor(s.itemCode)),
      );
}
