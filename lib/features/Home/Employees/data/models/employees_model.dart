import 'package:json_annotation/json_annotation.dart';

part 'employees_model.g.dart';

@JsonSerializable()
class Employees {
  @JsonKey(name: "status_code")
  int statusCode;
  @JsonKey(name: "error")
  int error;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "pagination")
  Pagination pagination;
  @JsonKey(name: "data")
  List<Employee> data;

  Employees({
    required this.statusCode,
    required this.error,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory Employees.fromJson(Map<String, dynamic> json) =>
      _$EmployeesFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeesToJson(this);
}

@JsonSerializable()
class Employee {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "employee_name")
  String employeeName;
  @JsonKey(name: "designation")
  String designation;
  @JsonKey(name: "service_cost")
  int serviceCost;
  @JsonKey(name: "shift")
  String shift;

  Employee({
    required this.name,
    required this.employeeName,
    required this.designation,
    required this.serviceCost,
    required this.shift,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "page")
  int page;
  @JsonKey(name: "limit")
  int limit;
  @JsonKey(name: "total_items")
  int totalItems;
  @JsonKey(name: "total_pages")
  int totalPages;

  Pagination({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
