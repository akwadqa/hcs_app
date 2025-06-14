import 'package:dio/dio.dart';

class SubmitServiceParams {
  final String customer;
  final String driver;
  final String date;
  final String serviceType;
  final String shiftType;
  final List<String>? days;
  final String employees;
  final String paymentMethod;

  SubmitServiceParams({
    required this.customer,
    required this.driver,
    required this.date,
    required this.serviceType,
    required this.shiftType,
    required this.days,
    required this.employees,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'driver': driver,
      'date': date,
      'service_type': serviceType,
      'shift_type': shiftType,
      'days': days,
      'employees': employees,
      'payment_method': paymentMethod,
    };
  }

  FormData toFormData() {
    return FormData.fromMap(toMap());
  }
}
