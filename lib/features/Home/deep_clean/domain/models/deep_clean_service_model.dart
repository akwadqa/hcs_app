import 'package:freezed_annotation/freezed_annotation.dart';
import 'service_field_model.dart';

part 'deep_clean_service_model.freezed.dart';
part 'deep_clean_service_model.g.dart';

@freezed
abstract class DeepCleanServiceModel with _$DeepCleanServiceModel {
  const factory DeepCleanServiceModel({
    required String id,
    required String name,
    String? subtitle,            // e.g. "Apartment · Up to 100 m²"
    double? price,
    @Default([]) List<ServiceField> fields, // optional (empty for these)
  }) = _DeepCleanServiceModel;

  factory DeepCleanServiceModel.fromJson(Map<String, dynamic> json) =>
      _$DeepCleanServiceModelFromJson(json);
}