import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/features/Home/Employees/data/repositories/employees_repository.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employees_controller.g.dart';

@riverpod
class EmployeesController extends _$EmployeesController {
  @override
  EmployeesState build() => EmployeesState();

  Future<void> selectEmployee(List<Employee>? selectedEmployee) async {
    state = state.copyWith(selectedEmployees: selectedEmployee);
    debugPrint("${state.selectedEmployees.toString()} llll");
  }

  Future<void> fetchEmployees() async {
    state = state.copyWith(employeesStates: RequestStates.loading);

    try {
      final employeesRepo = ref.read(employeesRepositoryProvider);
      final employeesData = await employeesRepo.getEmployees(page: 1);

      int? nextPage;
      //if there is a second page ?
      if (employeesData.pagination.totalPages > 1) {
        nextPage = 2;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentEmployeesPage: nextPage,
        employees: employeesData.data,
        employeesStates: RequestStates.loaded,
        employeesMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        employeesStates: RequestStates.error,
        employeesMessage: e.toString(),
      );
    }
  }

  Future<void> onLoadMoreEmployees() async {
    try {
      final employeesRepo = ref.read(employeesRepositoryProvider);
      final employeesData = await employeesRepo.getEmployees(
        page: state.currentEmployeesPage!,
      );

      int? nextPage;
      //if we reach the limit or not ?
      if (employeesData.pagination.totalPages > employeesData.pagination.page) {
        nextPage = employeesData.pagination.page + 1;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        currentEmployeesPage: nextPage,
        employees: [...state.employees, ...employeesData.data],
        employeesStates: RequestStates.loaded,
        employeesMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        employeesStates: RequestStates.error,
        employeesMessage: e.toString(),
      );
    }
  }
}
