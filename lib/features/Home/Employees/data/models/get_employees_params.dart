import 'package:equatable/equatable.dart';

class GetEmployeesParams extends Equatable {
  final String serviceType;
  final String date;
  final String shift;
  final String? serviceCategory;
  final String? employeeName;
  final int page;

  const GetEmployeesParams({
    required this.serviceType,
    required this.date,
    required this.shift,
    required this.serviceCategory,
    required this.employeeName,
    required this.page,
  });

  @override
  List<Object?> get props => [
    serviceType,
    date,
    shift,
    serviceCategory,
    employeeName,
    page,
  ];
}
