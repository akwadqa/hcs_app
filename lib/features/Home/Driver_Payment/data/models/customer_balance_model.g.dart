// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBalanceModel _$CustomerBalanceModelFromJson(
  Map<String, dynamic> json,
) => CustomerBalanceModel(
  statusCode: (json['status_code'] as num).toInt(),
  error: (json['error'] as num).toInt(),
  message: json['message'] as String,
  data: CustomerBalanceData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CustomerBalanceModelToJson(
  CustomerBalanceModel instance,
) => <String, dynamic>{
  'status_code': instance.statusCode,
  'error': instance.error,
  'message': instance.message,
  'data': instance.data,
};

CustomerBalanceData _$CustomerBalanceDataFromJson(Map<String, dynamic> json) =>
    CustomerBalanceData(
      outstandingBalance: (json['outstanding_balance'] as num).toDouble(),
      advanceBalance: (json['advance_balance'] as num).toDouble(),
    );

Map<String, dynamic> _$CustomerBalanceDataToJson(
  CustomerBalanceData instance,
) => <String, dynamic>{
  'outstanding_balance': instance.outstandingBalance,
  'advance_balance': instance.advanceBalance,
};
