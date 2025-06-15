import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/src/enums/request_state.dart';

class EmployeesState extends Equatable {
  //employees
  final int? currentEmployeesPage;
  final List<Employee> employees;
  final RequestStates employeesStates;
  final String? employeesMessage;
  final List<Employee> selectedEmployees;

  //service category
  final String? serviceCategory;

  const EmployeesState({
    //employees
    this.currentEmployeesPage,
    this.employees = const [],
    this.employeesStates = RequestStates.init,
    this.employeesMessage = '',
    this.selectedEmployees = const [
      Employee(
        name: "29906400056",
        employeeName: "Sonam Zangmo",
        designation: "Waitress",
        serviceCost: 100,
        shift: "Full Day",
      ),
    ],

    //service category
    this.serviceCategory = '',
  });
  EmployeesState copyWith({
    //employees
    int? currentEmployeesPage,
    List<Employee>? employees,
    RequestStates? employeesStates,
    String? employeesMessage,
    List<Employee>? selectedEmployees,

    //service category
    String? serviceCategory,
  }) {
    return EmployeesState(
      //employees
      currentEmployeesPage: currentEmployeesPage ?? this.currentEmployeesPage,
      employees: employees ?? this.employees,
      employeesStates: employeesStates ?? this.employeesStates,
      employeesMessage: employeesMessage ?? this.employeesMessage,
      selectedEmployees: selectedEmployees ?? this.selectedEmployees,

      //service category
      serviceCategory: serviceCategory ?? this.serviceCategory,
    );
  }

  @override
  List<Object?> get props => [
    //employees
    currentEmployeesPage,
    employees,
    employeesStates,
    employeesMessage, selectedEmployees, serviceCategory,
  ];
}
