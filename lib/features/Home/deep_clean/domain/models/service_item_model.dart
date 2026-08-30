import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_item_model.freezed.dart';
part 'service_item_model.g.dart';

@freezed
abstract class ServiceItemModel with _$ServiceItemModel {
  const factory ServiceItemModel({
    @JsonKey(name: 'item_code') required String itemCode,
    @JsonKey(name: 'item_name') required String itemName,
    double? rate,
  }) = _ServiceItemModel;

  factory ServiceItemModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceItemModelFromJson(json);
}