import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';

class SubmitServiceParams {
  final String customer;
  final String driver;
  final String date;
  final String serviceType;
  final String shiftType;
  final List<String>? days;
  final List<Employee> employees;
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
      'days': days, // Keep as-is; if backend expects string, only then encode
      'employees': employees
          .map(
            (e) => {
              'employee_name': e.employeeName,
              'occupation': e.designation,
              'monthly_contract_amount': e.serviceCost,
              'shift': e.shift,
            },
          )
          .toList(),
      'payment_method': paymentMethod,
    };
  }

  FormData toFormData() {
    return FormData.fromMap(toMap());
  }
}
