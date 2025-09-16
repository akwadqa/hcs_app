import 'package:flutter/foundation.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/features/Home/Employees/data/models/get_employees_params.dart';
import 'package:hcs/features/Home/Employees/data/repositories/employees_repository.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_state.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employees_controller.g.dart';

@riverpod
class EmployeesController extends _$EmployeesController {
    bool _isLoadingMore = false; // <-- guard

  @override
  EmployeesState build() => EmployeesState();

  selectServiceCategory(String serviceCategory) {
    state = state.copyWith(
      serviceCategory: serviceCategory,
      selectedEmployees: [],
    );

  }

  searchEmployee(String employeeName) {
    state = state.copyWith(employeeSearchedFor: employeeName);
    fetchEmployees();

  }

  selectEmployee(Employee selectedEmployee) {
    List<Employee> employeesList = List.from(state.selectedEmployees);
    int index = employeesList.indexWhere(
      (element) => element.employeeName == selectedEmployee.employeeName,
    );
    if (index == -1) {
      employeesList.add(selectedEmployee);
      state = state.copyWith(selectedEmployees: employeesList);
    }


  }

  unSelectEmployee(Employee unSelectedEmployee) {
    List<Employee> employeeList = List.from(state.selectedEmployees);
    int index = employeeList.indexWhere(
      (element) => element.employeeName == unSelectedEmployee.employeeName,
    );
    if (index != -1) {
      employeeList.removeAt(index);
    }
    state = state.copyWith(selectedEmployees: employeeList);
  }

  Future<void> fetchEmployees() async {
    state = state.copyWith(employeesStates: RequestStates.loading);

    try {
      final employeesRepo = ref.read(employeesRepositoryProvider);
      final availabilityController = ref.read(availabilityControllerProvider);

   

      final employeesData = await employeesRepo.getEmployees(
        getEmployeesParams: GetEmployeesParams(
          serviceType: availabilityController.selectedPackage?.id ?? 'Daily',
          date: availabilityController.selectedDate,
          days: availabilityController.selectedDays,
          shift: availabilityController.selectedShiftType,
          serviceCategory: state.serviceCategory,
          employeeName: state.employeeSearchedFor,
          page: 1,
        ),
      );

      final totalPages = employeesData.pagination.totalPages;
      final nextPage = totalPages > 1 ? 2 : null;

      state = state.copyWith(
        employees: employeesData.data,
        currentEmployeesPage: nextPage,
        // setCurrentEmployeesPage: true,  
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
        final next = state.currentEmployeesPage;
    // if (_isLoadingMore || next == null) return; // <-- guards

    _isLoadingMore = true;
    debugPrint('[Employees] load-more -> requesting page=$next');

    try {

      final employeesRepo = ref.read(employeesRepositoryProvider);
      final availabilityController = ref.read(availabilityControllerProvider);
     debugPrint('[Employees] load-more -> requesting page=$next');

      final employeesData = await employeesRepo.getEmployees(
        getEmployeesParams: GetEmployeesParams(
          serviceType: availabilityController.selectedPackage?.id ?? 'Daily',
          date: availabilityController.selectedDate,
          days: availabilityController.selectedDays,
          shift: availabilityController.selectedShiftType,
          serviceCategory: state.serviceCategory,
          employeeName: state.employeeSearchedFor,
          page: next!,
        ),
      );

      int? nextPage;
      //if we reach the limit or not ?
      if (employeesData.pagination.totalPages > employeesData.pagination.page) {
        nextPage = employeesData.pagination.page + 1;
      } else {
        nextPage = null;
      }
      state = state.copyWith(
        employees: [...state.employees, ...employeesData.data],
        currentEmployeesPage: nextPage,
        employeesStates: RequestStates.loaded,
      );

    } catch (e) {
      state = state.copyWith(
        employeesStates: RequestStates.error,
        employeesMessage: e.toString(),
      );
    }
  }

  //   Future<void> onLoadMoreEmployees() async {
  //     debugPrint('[onLoadMore] page=${state.currentEmployeesPage}');
  //   // hard guards
  //   if (_isLoadingMore) return;
  //     debugPrint('onLoadMoreEmployees called2');

  //   final next = state.currentEmployeesPage;
  //   if (next == null) return;
  //     debugPrint('onLoadMoreEmployees called3');

  //   _isLoadingMore = true;
  //   try {
  //     final employeesRepo = ref.read(employeesRepositoryProvider);
  //     final availability = ref.read(availabilityControllerProvider);

  //     final resp = await employeesRepo.getEmployees(
  //       getEmployeesParams: GetEmployeesParams(
  //         serviceType: availability.selectedPackage?.id ?? 'Daily',
  //         date: availability.selectedDate,
  //         days: availability.selectedDays,
  //         shift: availability.selectedShiftType,
  //         serviceCategory: state.serviceCategory,
  //         employeeName: state.employeeSearchedFor,
  //         page: next,
  //       ),
  //     );

  //     // compute next page safely
  //     final p = resp.pagination.page;
  //     final total = resp.pagination.totalPages;
  //     final newNext = (total > p) ? p + 1 : null;

  //     state = state.copyWith(
  //       employees: [...state.employees, ...resp.data],
  //       currentEmployeesPage: newNext,
  //       // keep overall state as loaded; don't flip to loading/error for load-more
  //       employeesStates: RequestStates.loaded,
  //       employeesMessage: '',
  //     );
  //   } catch (e) {
  //     // keep existing list; optionally stash the error message
  //     state = state.copyWith(employeesMessage: e.toString());
  //   } finally {
  //     _isLoadingMore = false;
  //   }
  // }
}
