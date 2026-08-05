import 'package:freezed_annotation/freezed_annotation.dart';
import 'deep_clean_service_model.dart';

part 'deep_clean_services_response.freezed.dart';
part 'deep_clean_services_response.g.dart';

@freezed
abstract class DeepCleanServicesResponse with _$DeepCleanServicesResponse {
  const factory DeepCleanServicesResponse({
    @Default([]) List<DeepCleanServiceModel> data,
  }) = _DeepCleanServicesResponse;

  factory DeepCleanServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$DeepCleanServicesResponseFromJson(json);
}