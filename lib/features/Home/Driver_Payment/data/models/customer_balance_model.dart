import 'package:json_annotation/json_annotation.dart';

part 'customer_balance_model.g.dart';

@JsonSerializable()
class CustomerBalanceModel {
  @JsonKey(name: "status_code")
  int statusCode;
  @JsonKey(name: "error")
  int error;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  CustomerBalanceData data;

  CustomerBalanceModel({
    required this.statusCode,
    required this.error,
    required this.message,
    required this.data,
  });

  factory CustomerBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerBalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerBalanceModelToJson(this);
}

@JsonSerializable()
class CustomerBalanceData {
  @JsonKey(name: "outstanding_balance")
  double outstandingBalance;
  @JsonKey(name: "advance_balance")
  double advanceBalance;


  CustomerBalanceData({
    required this.outstandingBalance,
    required this.advanceBalance,
  });

  factory CustomerBalanceData.fromJson(Map<String, dynamic> json) =>
      _$CustomerBalanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerBalanceDataToJson(this);
}
