import 'package:dio/dio.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';

class SubmitServiceParams {
  final String customerId;
  final String customerName;
  final String driver;
  final bool isPartTime;
  final String date;
  final String serviceType;
  final String shiftType;
  final List<String>? days;
  final List<Employee> employees;
  final String paymentMethod;
  final String note;
  final String? discountType;
  final String discountPercentage;
  final String totalAmount;
  final double? totalNetAmount;
  final double? discountCost;
  final double? cleaningSuppliesFees;
  final String withCleaningSupplies;

  SubmitServiceParams({
    required this.customerId,
    required this.customerName,
    required this.driver,
    required this.date,
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
  });

  Map<String, dynamic> toMap() {
    // final totalCostWithSuplies=(discountCost?? totalNetAmount?? totalAmount)+(cleaningSuppliesFees??0);
    final baseNet =
        discountCost ?? totalNetAmount ?? double.tryParse(totalAmount) ?? 0.0;
    final baseAmount = double.tryParse(totalAmount) ?? 0.0;
    final suppliesCost = cleaningSuppliesFees ?? 0.0;

    // Add supplies only if cost > 0
    final netWithSupplies = baseNet + (suppliesCost > 0 ? suppliesCost : 0);
    final baseAmountWithSupplies =
        baseAmount + (suppliesCost > 0 ? suppliesCost : 0);
    final partTime = isPartTime ? 1 : 0;

    return {
      'is_part_time' : partTime,
      'customer_name': customerName,
      'customer': customerId,
      'driver': driver,
      'date': date,
      'service_type': serviceType,
      'shift_type': shiftType,
      'days': days, // Keep as-is; if backend expects string, only then encode
      'employees': employees
          .map(
            (e) => {
              'employee_name': e.name,
              'occupation': e.designation,
              'monthly_contract_amount': e.serviceCost,
              'shift': e.shift,
            },
          )
          .toList(),
      'payment_method': paymentMethod,
      'note': note,
      if (discountType != null) 'discount_type': discountType,
      "total_amount": baseAmountWithSupplies,
      "total_net_amount": netWithSupplies,
      'discount_percentage': discountPercentage,
      'with_cleaning_supplies': withCleaningSupplies == 'yes' ? 1 : 0,
      'cleaning_fee': cleaningSuppliesFees,
    };
  }

  FormData toFormData() {
    return FormData.fromMap(toMap());
  }
}
