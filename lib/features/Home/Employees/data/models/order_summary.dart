import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';

class VisitSummary {
  final int visitNumber;
  final DateTime date;
  final String shiftType;
  final String serviceCategory;
  final List<Employee> employees;

  VisitSummary({
    required this.visitNumber,
    required this.date,
    required this.shiftType,
    required this.serviceCategory,
    required this.employees,
  });
}

class OrderSummary {
  final String serviceCategory;
  final String serviceType;
  final String shiftType;
  final List<VisitSummary> visits;

  OrderSummary({
    required this.serviceCategory,
    required this.serviceType,
    required this.shiftType,
    required this.visits,
  });
}
