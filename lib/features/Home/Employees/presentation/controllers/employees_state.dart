import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class EmployeesState extends Equatable {
  //employees
  final int? currentEmployeesPage;
  final List<Employee> employees;
  final RequestStates employeesStates;
  final String? employeesMessage;
  final List<Employee> selectedEmployees;

  const EmployeesState({
    //employees
    this.currentEmployeesPage,
    this.employees = const [],
    this.employeesStates = RequestStates.init,
    this.employeesMessage = '',
    this.selectedEmployees = const [],
  });
  EmployeesState copyWith({
    //employees
    int? currentEmployeesPage,
    List<Employee>? employees,
    RequestStates? employeesStates,
    String? employeesMessage,
    List<Employee>? selectedEmployees,
  }) {
    return EmployeesState(
      //employees
      currentEmployeesPage: currentEmployeesPage ?? this.currentEmployeesPage,
      employees: employees ?? this.employees,
      employeesStates: employeesStates ?? this.employeesStates,
      employeesMessage: employeesMessage ?? this.employeesMessage,
      selectedEmployees: selectedEmployees ?? this.selectedEmployees,
    );
  }

  @override
  List<Object?> get props => [
    //employees
    currentEmployeesPage,
    employees,
    employeesStates,
    employeesMessage, selectedEmployees,
  ];
}
