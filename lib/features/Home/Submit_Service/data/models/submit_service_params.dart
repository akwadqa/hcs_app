import 'package:dio/dio.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:intl/intl.dart';

class SubmitServiceParams {
  final String customerId;
  final String customerName;
  final String driver;
  final bool isPartTime;
  final String date;
  final String shift;
  final String serviceType;
  final String shiftType;
  final List<String>? days;
  final List<Employee> employees;
  final String paymentMethod;
  final String note;
  final String? discountType;
  final String? flexibleOption;
  final String? overTimeHours;
  final String discountPercentage;
  final String totalAmount;
  final double? totalNetAmount;
  final double? discountCost;
  final double? cleaningSuppliesFees;
  final bool withCleaningSupplies;
  final bool useAdvancedPayment;
  final bool? outstandingBalance;
  final Map<String, List<Employee>>? assignedEmployeesPerDate;

  SubmitServiceParams({
    required this.customerId,
    required this.customerName,
    required this.driver,
    required this.date,
    required this.shift,
    required this.serviceType,
    required this.isPartTime,
    required this.shiftType,
    required this.days,
    required this.employees,
    required this.paymentMethod,
    required this.note,
    required this.totalAmount,
    required this.totalNetAmount,
    required this.discountCost,
    required this.discountType,
    required this.discountPercentage,
    required this.cleaningSuppliesFees,
    required this.withCleaningSupplies,
    required this.useAdvancedPayment,
    this.assignedEmployeesPerDate,
    this.flexibleOption,
    this.overTimeHours,
    this.outstandingBalance,
  });

  Map<String, dynamic> toMap() {
    // final totalCostWithSuplies=(discountCost?? totalNetAmount?? totalAmount)+(cleaningSuppliesFees??0);
    // New employees mapping based on assignedEmployeesPerDate
    String getDayName(String dateString) {
      // Step 1: Parse using correct pattern
      DateTime date = DateTime.parse(dateString); // works for yyyy-MM-dd

      // Step 2: Format to get weekday
      return DateFormat('EEEE').format(date); // Monday, Tuesday, ...
    }

    final baseNet =
        discountCost ?? totalNetAmount ?? double.tryParse(totalAmount) ?? 0.0;
    final baseAmount = double.tryParse(totalAmount) ?? 0.0;
    final suppliesCost = cleaningSuppliesFees ?? 0.0;

    // Add supplies only if cost > 0
    final netWithSupplies = baseNet + (suppliesCost > 0 ? suppliesCost : 0);
    final baseAmountWithSupplies =
        baseAmount + (suppliesCost > 0 ? suppliesCost : 0);
    final partTime = isPartTime ? 1 : 0;
    List<Map<String, dynamic>> mappedEmployeesFromAssigned(
      Map<String, List<Employee>>? assignedEmployeesPerDate,
    ) {
      if (assignedEmployeesPerDate == null) return [];

      final List<Map<String, dynamic>> data = [];

      assignedEmployeesPerDate.forEach((date, employeesList) {
        for (var emp in employeesList) {
          data.add({
            'employee_name': emp.name,
            'occupation': emp.designation,
            'shift': emp.shift,
            'base_amount': baseAmount,
            'monthly_contract_amount': emp.serviceCost,
            'date': date,
            "day": getDayName(date),
            // 'day': emp.day, // if stored inside Employee model
          });
        }
      });

      return data;
    }

    return {
      'is_part_time': partTime,
      // 'customer_name': customerName,
      'customer': customerId,
      'driver': driver,
      'date': date,
      'with_cleaning_supplies': withCleaningSupplies ? 1 : 0,

      // 'shift': shift,
      'service_type': serviceType,
      if (overTimeHours != null) "overtime_hours": overTimeHours,
      if (flexibleOption != null) "flexible_option": "$flexibleOption visits",
      'shift_type': shiftType,
      // 'days': days, // Keep as-is; if backend expects string, only then encode
      'employees': assignedEmployeesPerDate != null
          ? mappedEmployeesFromAssigned(assignedEmployeesPerDate)
          : employees
                .map(
                  (e) => {
                    'employee_name': e.name,
                    'occupation': e.designation,
                    'monthly_contract_amount': e.serviceCost,
                    'shift':shiftType,
                    'date': date,
                    "day": getDayName(date),
                    // "day":"monday"
                  },
                )
                .toList(),
      'payment_method': paymentMethod,
      'use_advance_payment': useAdvancedPayment ? 1 : 0,

      'note': note,

      if (discountType != null) 'discount_type': discountType,
      'discount_percentage': discountPercentage,

      // "total_amount": baseAmountWithSupplies,
      // "total_net_amount": netWithSupplies,
      "outstanding_balance":
          outstandingBalance == true || outstandingBalance != null ? 1 : 0,

      'cleaning_fee': cleaningSuppliesFees,
    };
  }

  FormData toFormData() {
    return FormData.fromMap(toMap());
  }
}
