
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hcs/features/Home/Availability/data/models/packages_model.dart';
import 'package:hcs/features/Home/Availability/data/repositories/availability_repo.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/service_config_state.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/src/enums/request_state.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Employees/data/models/order_summary.dart';

part 'availability_controller.g.dart';

@riverpod
class AvailabilityController extends _$AvailabilityController {
  @override
  ServiceConfigState build() => const ServiceConfigState();

  // ------------------------------------------------
  // GETTERS
  // ------------------------------------------------
  int get assignedDatesCount => state.assignedDates?.length ?? 0;
  bool get hasRemainingDates => remainingVisits.isNotEmpty;

  int get requiredVisits =>
     state.selectedPackage?.numberOfVisits  ?? 0;

  int get selectedDatesCount => state.generatedDates?.length ?? 0;

  int get missingVisits => (requiredVisits - assignedDatesCount);

  bool get hasUnassignedVisits => missingVisits > 0;

  // ------------------------------------------------
  // SELECTORS
  // ------------------------------------------------

  void selectService(String selectedServiceType) {
    state = state.copyWith(selectedServiceType: selectedServiceType);
  }

  void selectShift(String shift) {
    state = state.copyWith(selectedShiftType: shift);
    _generateDates();
  }

  void changePartTime(bool isPartTime) {
    state = state.copyWith(isPartTime: isPartTime);
    _generateDates();
  }

  void selectDate(String selectedDate) {
    state = state.copyWith(selectedDate: selectedDate);
    _generateDates();
  }

  void selectPackage(PackagesData package) {
    state = state.copyWith(selectedPackage: package);
    _generateDates();
  }

  void selectPartTimeShift(String partTimeShift) {
    // partTimeShift => "morning" OR "evening"

    state = state.copyWith(
      // selectedShiftType: "Part Time ($partTimeShift)",
      selectedPartTimeShift: partTimeShift,
    );
  debugPrint(
        "selectedShiftType : ${state.selectedShiftType} → $partTimeShift}}",
      );
    // regenerate dates based on PT rules
    // _generateDates();

    // refresh employees
    // ref.read(employeesControllerProvider.notifier).fetchEmployees(page: 1);
  }

  // ------------------------------------------------
  // DAY SELECTION
  // ------------------------------------------------
  void toggleDaySelection(String day) {
    final List<String> days = [...state.selectedDays];

    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }

    state = state.copyWith(selectedDays: days);
    debugPrint('[toggleDaySelection] selectedDays updated -> $days');

    _generateDates();
  }
void resetSelectedDays() {
  state = state.copyWith(
    selectedDays: [],
    generatedDates: [],
    firstVisitDate: '',
    lastVisitDate: '',
  );
}
void submitSelectedDays(){
  state=state.copyWith(submitOrderSelectedDays: [...state.selectedDays]);
  state=state.copyWith(selectedDays: []);
}
  // ------------------------------------------------
  // AUTO GENERATE DATES
  // ------------------------------------------------
  void _generateDates() {
    final days = state.selectedDays;
    final visits = requiredVisits;
    debugPrint(
      '*******[_generateDates] selectedDays=$days requiredVisits=$visits *******',
    );

    if (days.isEmpty || visits == 0) {
      state = state.copyWith(generatedDates: []);
      debugPrint(
        '[_generateDates] no days or no visits -> cleared generatedDates',
      );

      return;
    }

    final base = DateFormat('yyyy-MM-dd').parse(state.selectedDate);

    DateTime start = base;

    final assigned = (state.assignedDates ?? []).toList()..sort();
    final slotsNeeded = visits - assigned.length;
    if (slotsNeeded <= 0) {
      // All slots filled, only show assigned
      state = state.copyWith(
        generatedDates: assigned,
        firstVisitDate: assigned.isNotEmpty ? format(assigned.first) : '',
        lastVisitDate: assigned.isNotEmpty ? format(assigned.last) : '',
      );
      debugPrint(
        '[_generateDates] All slots filled, showing only assigned dates',
      );
      return;
    }
    int safety = 0;
    // DateTime current = assigned.isNotEmpty ? assigned.last : base;
    DateTime current =  base;

    List<DateTime> newDates = [];

    while (newDates.length < slotsNeeded && safety < 365) {
      current = current.add(const Duration(days: 1));
      final weekdayName = _weekdayToString(current.weekday);

      if (days.contains(weekdayName)) {
        // Skip if already assigned
        final isAssigned = assigned.any((d) => _isSameDay(d, current));
        if (!isAssigned && !_partTimeConflict(current)) {
          newDates.add(current);
          debugPrint('[_generateDates] Generated new date: ${format(current)}');
        }
      }
      safety++;
    }

    // Combine assigned + new generated dates
    final combined = [...assigned, ...newDates]..sort();

    state = state.copyWith(
      generatedDates: combined,
      firstVisitDate: combined.isNotEmpty ? format(combined.first) : '',
      lastVisitDate: combined.isNotEmpty ? format(combined.last) : '',
    );

    debugPrint(
      '[_generateDates] Final: total=${combined.length} (assigned=${assigned.length} + generated=${newDates.length})',
    );
    debugPrint(
      '[_generateDates] Dates: ${combined.map((d) => format(d)).toList()}',
    );
    //   if (assigned.isNotEmpty) {
    //     // last assigned date
    //     start = assigned.last;
    //     debugPrint(
    //       '[_generateDates] starting after last assigned date: ${format(start)}',
    //     );
    //   } else {
    //     debugPrint(
    //       '[_generateDates] starting from base selectedDate: ${format(base)}',
    //     );
    //   }

    // DateTime current = assigned.isNotEmpty ? assigned.last : base;

    //   // result starts with existing assigned dates so they remain locked
    //   List<DateTime> result = List<DateTime>.from(assigned);

    //   while (result.length < visits) {
    //     current = current.add(const Duration(days: 1));
    //     final weekdayName = _weekdayToString(current.weekday);

    //     if (days.contains(weekdayName)) {
    //       // prevent duplicates
    //       final exists = result.any((d) => _isSameDay(d, current));
    //       if (!exists && !_partTimeConflict(current)) {
    //         result.add(current);
    //         debugPrint(
    //           '[_generateDates] added generated date: ${format(current)}',
    //         );
    //       }
    //     }
    //     if (current.difference(start).inDays > 365) {
    //       debugPrint('[_generateDates] safety break after 365 days');
    //       break;
    //     }
    //   }

    //   result.sort();

    //   state = state.copyWith(
    //     generatedDates: result,
    //     firstVisitDate: result.isNotEmpty ? format(result.first) : '',
    //   lastVisitDate: result.isNotEmpty ? format(result.last) : '',
    //   );
    //     debugPrint('[ _generateDates ] final generatedDates: ${result.map((d)=>format(d)).toList()}');
  }

  OrderSummary buildOrderSummary() {
    final assignedDates = state.assignedDates ?? [];
    final employeesMap = state.assignedEmployeesPerDate ?? {};
    final shiftMap = state.assignedShiftPerDate ?? {};
    assignedDates.sort((a, b) => a.compareTo(b));
    final dates = state.generatedDates ?? [];

    List<VisitSummary> visits = [];
    employeesMap.forEach((date, employees) {
      debugPrint(
        "EMPLOYEE FUN: $date → ${employees.map((e) => e.employeeName).join(', ')}",
      );
    });
    for (int i = 0; i < assignedDates.length; i++) {
      final date = assignedDates[i];
      final key = format(date);
  debugPrint(
        "selectedShiftType FUN: $date → ${shiftMap[key]}}",
      );
      visits.add(
        VisitSummary(
          visitNumber: i + 1,
          date: date,
          serviceCategory: state.assignedServiceCategory?[key] ?? "kk",
          shiftType: shiftMap[key] ?? state.selectedShiftType,
          employees: employeesMap[key] ?? [],
        ),
      );
    }
    debugPrint('[buildOrderSummary] visits:');
    for (final v in visits) {
      debugPrint(
        '  visit ${v.visitNumber}: ${format(v.date)} shift=${v.shiftType} employees=${v.employees.map((e) => e.employeeName).toList()}',
      );
    }

    debugPrint("?????????????");
    return OrderSummary(
      serviceCategory: state.selectedServiceType ?? "",
      serviceType: state.selectedPackage?.id ?? "",
      shiftType: state.selectedShiftType,
      visits: visits,
    );
  }

  // ------------------------------------------------
  // MANUAL DATE MANAGEMENT
  // ------------------------------------------------
  bool tryAddManualDate(DateTime date) {
    final list = List<DateTime>.from(state.generatedDates ?? []);

    // cannot exceed required visits
    if (list.length >= requiredVisits) return false;

    // prevent duplicate date
    if (list.any((d) => _isSameDay(d, date))) return false;

    // part-time rule: can't add two visits same day
    if (_partTimeConflict(date)) return false;

    list.add(date);
    list.sort();

    state = state.copyWith(generatedDates: list);
    return true;
  }

  void removeGeneratedDate(DateTime date) {
    final list = List<DateTime>.from(state.generatedDates ?? []);
    list.removeWhere((d) => _isSameDay(d, date));

    state = state.copyWith(generatedDates: list);
  }

  // number of visits left to select
  List<DateTime> get remainingVisits {
    final assigned = state.assignedDates ?? [];
    final generated = state.generatedDates ?? [];
    // remove already assigned dates
    return generated
        .where((d) => !assigned.any((a) => _isSameDay(a, d)))
        .toList();
  }

 void selectDayFromDate(DateTime date) {
  final day = DateFormat('EEEE').format(date).toLowerCase();
 final newDays = state.generatedDates!
        .map((d) => DateFormat('EEEE').format(d).toLowerCase())
        .toSet()
        .toList();
  // do not override existing user selections
  if (!state.selectedDays.contains(day)&newDays.isNotEmpty) {
    state = state.copyWith(
      selectedDays: [...state.selectedDays, day],
    );
  }
}

  void updateSelectedDaysFromDates(List<DateTime> dates) {
    // convert weekdays to lowercase strings
     String? day;
  for (final d in dates) {

   day = DateFormat('EEEE').format(d).toLowerCase();
  }
    final newDays = dates
        .map((d) => DateFormat('EEEE').format(d).toLowerCase())
        .toSet()
        .toList();

    state = state.copyWith(selectedDays:  [...newDays, day!]);
  }

  // ------------------------------------------------
  // HELPERS
  // ------------------------------------------------
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _weekdayToString(int w) {
    switch (w) {
      case DateTime.sunday:
        return 'sunday';
      case DateTime.monday:
        return 'monday';
      case DateTime.tuesday:
        return 'tuesday';
      case DateTime.wednesday:
        return 'wednesday';
      case DateTime.thursday:
        return 'thursday';
      case DateTime.friday:
        return 'friday';
      case DateTime.saturday:
        return 'saturday';
      default:
        return 'sunday';
    }
  }

  bool _partTimeConflict(DateTime date) {
    if (!state.isPartTime) return false;
    return (state.generatedDates ?? []).any((d) => _isSameDay(d, date));
  }

  String format(DateTime d) => DateFormat('yyyy-MM-dd').format(d);
  void calculateVisitDates() {
    final pkg = state.selectedPackage;
    final selectedDays = state.selectedDays;

    // no package or no selected days = nothing to calculate
    if (pkg == null || selectedDays.isEmpty) {
      state = state.copyWith(
        generatedDates: [],
        firstVisitDate: '',
        lastVisitDate: '',
      );
      return;
    }
    String weekdayName(DateTime date) {
      return DateFormat('EEEE').format(date);
    }

    final requiredVisits = pkg.numberOfVisits  ?? 0;
    if (requiredVisits == 0) return;

    final today = DateTime.now();
    List<DateTime> generated = [];

    DateTime current = today;

    while (generated.length < requiredVisits) {
      // Check if current day name is selected
      final weekdayName = DateFormat(
        'EEEE',
      ).format(current); // Sunday, Monday...
      final isMatch = selectedDays.contains(weekdayName);

      if (isMatch) {
        generated.add(DateTime(current.year, current.month, current.day));
      }

      current = current.add(const Duration(days: 1));
    }

    // final output
    generated.sort();

    state = state.copyWith(
      generatedDates: generated,
      firstVisitDate: DateFormat('yyyy-MM-dd').format(generated.first),
      lastVisitDate: DateFormat('yyyy-MM-dd').format(generated.last),
    );
  }

  void cleanAfterApply() {
    state = state.copyWith();
  }

  void resetSelectionsOnFilterChange() {
    state = state.copyWith(
      selectedDays: [],
      assignedDates: state.assignedDates, // keep assigned dates
      // if needed, also reset selectedDate
    );

  }
void resetAllSelections() {
  state = state.copyWith(
    selectedServiceType: null,
    selectedShiftType: null,
    selectedPartTimeShift: null,
    selectedDays: [],
    selectedDate: '',
    selectedPackage: null,
    generatedDates: [],
    firstVisitDate: '',
    lastVisitDate: '',
    assignedDates: [],
    assignedEmployeesPerDate: {},
    assignedShiftPerDate: {},
    assignedServiceCategory: {},
    selectedVisitDate: null,
  );
}

  void resetAll() {
    state = build();
  }

  /// Replace all dates with user-selected dates from calendar
  void updateManualSelection(List<DateTime> selected) {
    final max = requiredVisits;
    final assigned = state.assignedDates ?? [];
    // only allow selection for remaining slots
    final slotsLeft = max - assigned.length;
    debugPrint(
      '[updateManualSelection] selected(raw)=${selected.map((d) => format(d)).toList()} assigned=${assigned.map((d) => format(d)).toList()} slotsLeft=$slotsLeft',
    );

    List<DateTime> clean =
        selected
            .where(
              (d) =>
                  !_partTimeConflict(d) &&
                  !assigned.any((a) => _isSameDay(a, d)),
            ) // <-- enforce part-time rule
            .toSet()
            .toList()
          ..sort();
    if (clean.length > slotsLeft) {
      clean = clean.take(slotsLeft).toList();
    }
    final combined = [...assigned, ...clean];
    state = state.copyWith(generatedDates: combined);
  // for (final d in selected) {
  //   selectDayFromDate(d);
  // }
    updateSelectedDaysFromDates(selected ?? []);

    debugPrint(
      '[updateManualSelection] applied generatedDates=${combined.map((d) => format(d)).toList()}',
    );

    // state = state.copyWith(generatedDates: [...assigned, ...clean]);
    // updateSelectedDaysFromDates(state.generatedDates!);
  }

  void assignEmployees(List<Employee> employees, String serviceCategory) {
    final assignedDates = List<DateTime>.from(state.assignedDates ?? []);
    final assignedEmployees = Map<String, List<Employee>>.from(
      state.assignedEmployeesPerDate ?? {},
    );
    final assignedShift = Map<String, String>.from(
      state.assignedShiftPerDate ?? {},
    );
    final assignedServiceCategory = Map<String, String>.from(
      state.assignedServiceCategory ?? {},
    );
    // final employeeNotifier = ref.read(employeesControllerProvider);
    final remaining = remainingVisits;

    debugPrint(
      '[assignEmployees] Locking ${remaining.length} dates with ${employees.length} employees',
    );

    if (remaining.isEmpty) {
      debugPrint('[assignEmployees] No remaining visits to lock');
      return;
    }

    // Verify employees are already in the map (added by addEmployeeToCurrentDates)
    for (final date in remaining) {
      final key = format(date);

      // Use existing employees from map or fall back to passed employees
      if (!assignedEmployees.containsKey(key) ||
          assignedEmployees[key]!.isEmpty) {
        assignedEmployees[key] = employees;
      }

      assignedShift[key] = (state.selectedShiftType.contains("Part")||state.selectedShiftType.startsWith("Part")&&state.selectedPartTimeShift!=null)?state.selectedPartTimeShift!:state.selectedShiftType;
      assignedServiceCategory[key] =serviceCategory;

      debugPrint(
        '[assignEmployees] Locked $key: ${assignedEmployees[key]!.map((e) => e.employeeName).toList()}',
      );
    }

    // Move remaining dates to assigned (lock them)
    assignedDates.addAll(remaining);
    assignedDates.sort();

    // Remove locked dates from generated
    final updatedGenerated = (state.generatedDates ?? [])
        .where((d) => !remaining.any((r) => _isSameDay(r, d)))
        .toList();

    state = state.copyWith(
      assignedDates: assignedDates,
      assignedEmployeesPerDate: assignedEmployees,
      assignedShiftPerDate: assignedShift,
      assignedServiceCategory: assignedServiceCategory,
      generatedDates: updatedGenerated,
    );
    // _generateDates();

    debugPrint(
      '[assignEmployees] Updated state: assigned=${assignedDates.length}, generated=${updatedGenerated.length}',
    );
  }

  /// Select an employee for a specific date
  //   void selectEmployeeForDate(Employee employee, DateTime date) {
  //     final dateKey = DateFormat('yyyy-MM-dd').format(date);
  //     final current = state.assignedEmployeesPerDate?[dateKey] ?? [];
  //     if (!current.contains(employee)) {
  //       final updated = List<Employee>.from(current)..add(employee);
  //       state = state.copyWith(
  //         assignedEmployeesPerDate: {
  //           ...?state.assignedEmployeesPerDate,
  //           dateKey: updated,
  //         },
  //       );
  //     }
  //   }

  //   /// Unselect an employee for a specific date
  //   void unSelectEmployeeForDate(Employee employee, DateTime date) {
  //     final dateKey = DateFormat('yyyy-MM-dd').format(date);
  //     final current = state.assignedEmployeesPerDate?[dateKey] ?? [];
  //     if (current.contains(employee)) {
  //       final updated = List<Employee>.from(current)..remove(employee);
  //       state = state.copyWith(
  //         assignedEmployeesPerDate: {
  //           ...?state.assignedEmployeesPerDate,
  //           dateKey: updated,
  //         },
  //       );
  //     }
  //   }
  //  List<Employee> getEmployeesForDate(DateTime date) {
  //     final key = DateFormat('yyyy-MM-dd').format(date);
  //     return state.assignedEmployeesPerDate?[key] ?? [];
  //   }
  void addEmployeeToCurrentDates(Employee employee) {
    final currentDates = remainingVisits;
    debugPrint(
      'generatedDates:>>> ${state.generatedDates!.map((e) => e).toList()} : remainingVisits:>>>> ${remainingVisits.map((e) => e).toList()}',
    );
    debugPrint(
      '[addEmployeeToCurrentDates] Adding ${employee.employeeName} to ${currentDates.length} remaining dates: ${currentDates.map((d) => format(d)).toList()}',
    );

    final updatedEmployeesMap = {...?state.assignedEmployeesPerDate};

    for (final date in currentDates) {
      final key = format(date);

      final list = updatedEmployeesMap[key] ?? [];
      if (!list.any((e) => e.employeeName == employee.employeeName)) {
        updatedEmployeesMap[key] = [...list, employee];
        debugPrint(
          '[addEmployeeToCurrentDates] Added to $key: ${employee.employeeName}',
        );
      }
    }
    updatedEmployeesMap.forEach((key, value) {
      debugPrint(
        '  KEY: $key => EMPLOYEES: ${value.map((e) => e.employeeName).toList()}',
      );
    });
    state = state.copyWith(
      assignedEmployeesPerDate: updatedEmployeesMap,
      assignedShiftPerDate: {
        ...?state.assignedShiftPerDate,
        for (final d in currentDates) format(d): state.selectedShiftType,
      },
      // assignedDates: [
      //   ...?state.assignedDates,
      //   ...currentDates,
      // ]..toSet().toList(),
    );
  }

  void removeEmployeeFromCurrentDates(Employee employee) {
    final currentDates = remainingVisits; // Only unassigned dates

    final updatedEmployeesMap = {...?state.assignedEmployeesPerDate};

    for (final date in currentDates) {
      final key = format(date);

      final list = updatedEmployeesMap[key] ?? [];
      updatedEmployeesMap[key] = list
          .where((e) => e.name != employee.name)
          .toList();
    }

    state = state.copyWith(assignedEmployeesPerDate: updatedEmployeesMap);
  }

  void selectVisitDate(DateTime date) {
    state = state.copyWith(selectedVisitDate: date);
  }

  // ------------------------------------------------
  // FETCH PACKAGES (your old logic kept)
  // ------------------------------------------------
  Future<void> fetchPackages() async {
    //         var selectedPackageState = ref.watch(
    //   availabilityControllerProvider.select((value) => value.selectedPackage),
    // );
    //   final selectedServiceType = ref.watch( 
    //   availabilityControllerProvider.select((s) => s.selectedServiceType),
    // );
    final bool dailyService =state. selectedPackage?.id == 'Daily'||stringToServiceType(state.selectedServiceType ?? "On Call") !=
                  ServiceType.packages;

    state = state.copyWith(
      packagesStates: RequestStates.loading,
      selectedShiftType: 'Morning Shift',
      selectedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      selectedDays: [],
      firstVisitDate: '',
      lastVisitDate: '',
      generatedDates: [],
    );
if(!dailyService) {
  try {
      final repo = ref.read(availabilityRepositoryProvider);
      final pkgs = await repo.getPackages();

      if (state.selectedServiceType == 'Packages') {
        debugPrint("state.selectedServiceType == 'Packages fdfghjklkjhgfdsfghj");
        final filtered = pkgs.data
            .where((e) => e.numberOfVisits != null)
            .toList();

        state = state.copyWith(
          packages: filtered,
          selectedPackage: filtered.isNotEmpty ? filtered.first : null,
          packagesStates: RequestStates.loaded,
        );
      } else {
        debugPrint("state.selectedServiceType == 'Daily gfdfghjklkjhgfdsfghj");

        final daily = pkgs.data.firstWhere(
          (e) => e.id == 'Daily',
          orElse: () => pkgs.data.first,
        );

        state = state.copyWith(
          packages: pkgs.data,
          selectedPackage: daily,
          packagesStates: RequestStates.loaded,
        );
      }

      _generateDates();
    } catch (e) {
      state = state.copyWith(
        packagesStates: RequestStates.error,
        packagesMessage: e.toString(),
      );
    }
}
  }
}

