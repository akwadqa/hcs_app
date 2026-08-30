import 'package:equatable/equatable.dart';
import 'package:hcs/features/Home/Availability/data/models/packages_model.dart';
import 'package:hcs/src/enums/request_state.dart';

import '../../../Employees/data/models/employees_model.dart';

class ServiceConfigState extends Equatable {
  final String? selectedServiceType;
  final String selectedShiftType;
  final bool isPartTime;
  final PackagesData? selectedPackage;
  final String selectedDate;
  final List<PackagesData> packages;
  final RequestStates packagesStates;
  final String? packagesMessage;
  final List<String> selectedDays; // New field
  final List<String> submitOrderSelectedDays; // New field
  final String firstVisitDate;
  final String lastVisitDate;
  final List<DateTime>? generatedDates;
  final String? selectedPartTimeShift;

  final List<DateTime>? assignedDates; // already reserved (locked) dates
  final Map<String, List<Employee>>?
  assignedEmployeesPerDate; // key: 'yyyy-MM-dd'
  final Map<String, String>?
  assignedShiftPerDate; // key: 'yyyy-MM-dd' -> shift string
  final Map<String, String>?
  assignedServiceCategory; // key: 'yyyy-MM-dd' -> shift string
  final int? remainingVisits;


  final DateTime? selectedVisitDate;

  const ServiceConfigState({
    this.selectedServiceType,
    this.selectedShiftType = 'Morning Shift',
    this.selectedPackage,
    this.selectedDate = '',
    this.packages = const [],
    this.isPartTime = false,
    this.packagesStates = RequestStates.init,
    this.packagesMessage = '',
    this.selectedDays = const [],
    this.submitOrderSelectedDays = const [],
    this.firstVisitDate = '',
    this.lastVisitDate = '',
    this.selectedPartTimeShift = '',
    this.generatedDates,
    this.assignedDates,
    this.assignedEmployeesPerDate,
    this.assignedShiftPerDate,
    this.remainingVisits,
    this.selectedVisitDate,
    this.assignedServiceCategory,
  });

  ServiceConfigState copyWith({
    String? selectedServiceType,
    String? selectedShiftType,
    PackagesData? selectedPackage,
    bool? isPartTime,
    String? selectedDate,
    List<PackagesData>? packages,
    List<DateTime>? generatedDates,
    RequestStates? packagesStates,
    String? packagesMessage,
    List<String>? selectedDays,
    List<String>? submitOrderSelectedDays,
    String? firstVisitDate,
    String? lastVisitDate,
    String? selectedPartTimeShift,
    int? remainingVisits,
    List<DateTime>? assignedDates,
    Map<String, List<Employee>>? assignedEmployeesPerDate,
    Map<String, String>? assignedShiftPerDate,
    Map<String, String>? assignedServiceCategory,
    DateTime? selectedVisitDate,
  }) {
    return ServiceConfigState(
      selectedServiceType: selectedServiceType ?? this.selectedServiceType,
      selectedShiftType: selectedShiftType ?? this.selectedShiftType,
      selectedPackage: selectedPackage ?? this.selectedPackage,
      selectedDate: selectedDate ?? this.selectedDate,
      packages: packages ?? this.packages,
      isPartTime: isPartTime ?? this.isPartTime,
      packagesStates: packagesStates ?? this.packagesStates,
      packagesMessage: packagesMessage ?? this.packagesMessage,
      selectedDays: selectedDays ?? this.selectedDays,
      submitOrderSelectedDays: submitOrderSelectedDays ?? this.submitOrderSelectedDays,
      firstVisitDate: firstVisitDate ?? this.firstVisitDate,
      lastVisitDate: lastVisitDate ?? this.lastVisitDate,
      generatedDates: generatedDates ?? this.generatedDates,
      selectedPartTimeShift:
          selectedPartTimeShift ?? this.selectedPartTimeShift,
      assignedDates: assignedDates ?? this.assignedDates,
      assignedEmployeesPerDate:
          assignedEmployeesPerDate ?? this.assignedEmployeesPerDate,
      assignedShiftPerDate: assignedShiftPerDate ?? this.assignedShiftPerDate,
      remainingVisits: remainingVisits ?? this.remainingVisits,
      selectedVisitDate: selectedVisitDate ?? this.selectedVisitDate,
      assignedServiceCategory: assignedServiceCategory ?? this.assignedServiceCategory,
    );
  }

  @override
  List<Object?> get props => [
    selectedServiceType,
    selectedShiftType,
    selectedPackage,
    selectedDate,
    packages,
    packagesStates,
    selectedDays,
    submitOrderSelectedDays,
    firstVisitDate,
    lastVisitDate,
    generatedDates,
    selectedPartTimeShift,
    assignedDates,
    assignedEmployeesPerDate,
    assignedShiftPerDate,
    remainingVisits,
    selectedVisitDate,
    assignedServiceCategory,
  ];
}
