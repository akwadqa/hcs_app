import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_clean_order_params.freezed.dart';
part 'deep_clean_order_params.g.dart';

@freezed
abstract class DeepCleanOrderParams with _$DeepCleanOrderParams {
  const factory DeepCleanOrderParams({
    @JsonKey(name: 'customer_id')  required String customerId,
    @JsonKey(name: 'service_ids')  required List<String> serviceIds,
    @JsonKey(name: 'service_type') required String serviceType,
    required String shift,
    required DateTime date,
    // required Map<String, dynamic> details,
  }) = _DeepCleanOrderParams;

  factory DeepCleanOrderParams.fromJson(Map<String, dynamic> json) =>
      _$DeepCleanOrderParamsFromJson(json);
}