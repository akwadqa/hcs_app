import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/features/Home/Availability/presentation/widgets/date_selection_widget.dart';
import 'package:hcs/features/Home/Employees/presentation/controllers/employees_controller.dart';
import 'package:hcs/src/enums/service_type.dart';
import 'package:intl/intl.dart';
import 'package:hcs/features/Home/Availability/presentation/controllers/availability_controller.dart';
import 'package:hcs/src/theme/app_colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class DateSelectionWidget extends ConsumerWidget {
  const DateSelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generated =
        ref.watch(
          availabilityControllerProvider.select((s) => s.generatedDates),
        ) ??
        [];

    final assigned =
        ref.watch(
          availabilityControllerProvider.select((s) => s.assignedDates),
        ) ??
        [];
    final selectedDays = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedDays),
    );
    // show unassigned generated dates (controller already ensures generatedDates are unassigned)
    final unassigned = generated;

    if (unassigned.isEmpty) {
      return const Text("No dates generated yet.");
    }
        final ctrl = ref.read(availabilityControllerProvider.notifier);

      final remainingDates = ctrl.remainingVisits;

    if (remainingDates.isEmpty) {
      return const Text("No remaining dates to assign.");
    }

    if (remainingDates.isEmpty) {
      return const Text("No remaining dates for selected days.");
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,

            children: remainingDates.map((d) {
              final dt = d;
              final label = DateFormat('EEE, dd MMM').format(dt);

              return Chip(
                label: Text(label),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                onDeleted: () {
                  // allow user to unselect an auto-generated date
                  // ref
                  //     .read(availabilityControllerProvider.notifier)
                  //     .removeGeneratedDate(d);
                  final isAssigned = (assigned).any(
                    (a) =>
                        a.year == d.year &&
                        a.month == d.month &&
                        a.day == d.day,
                  );
                  if (!isAssigned) {
                    ref
                        .read(availabilityControllerProvider.notifier)
                        .removeGeneratedDate(d);
                  } else {
                    // assigned - don't allow deletion
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Cannot remove"),
                        content: const Text("This date is already assigned."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class DateSelectionCalendarWidget extends ConsumerStatefulWidget {
  const DateSelectionCalendarWidget({super.key});

  @override
  ConsumerState<DateSelectionCalendarWidget> createState() =>
      _DateSelectionCalendarWidgetState();
}

class _DateSelectionCalendarWidgetState
    extends ConsumerState<DateSelectionCalendarWidget> {
  final DateRangePickerController _controller = DateRangePickerController();
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
  @override
  Widget build(BuildContext context) {
    final ctrl = ref.read(availabilityControllerProvider.notifier);

    final assigned =
        ref.watch(
          availabilityControllerProvider.select((s) => s.assignedDates),
        ) ??
        [];
    final generated =
        ref.watch(
          availabilityControllerProvider.select((s) => s.generatedDates),
        ) ??
        [];
    final employeesSelected = ref.watch(
      employeesControllerProvider.select((s) => s.selectedEmployees.isNotEmpty),
    );
    final selectedDateState = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedDate),
    );
        var selectedPackageState = ref.watch(
      availabilityControllerProvider.select((value) => value.selectedPackage),
    );
      final selectedServiceType = ref.watch(
      availabilityControllerProvider.select((s) => s.selectedServiceType),
    );
    final bool dailyService = selectedPackageState?.id == 'Daily'||stringToServiceType(selectedServiceType ?? "On Call") !=
                  ServiceType.packages;
    // final remaining = ref.read(
    //   availabilityControllerProvider.notifier.select((s) => s.remainingVisits),
    // );
        final allDates = generated..sort();

    final remaining = generated
        .where((d) => !assigned.any((a) => _isSameDay(a, d)))
        .toList();
    final initialSelected = [...assigned, ...remaining]
      ..sort((a, b) => a.compareTo(b));

    final dates =
        ref.watch(
          availabilityControllerProvider.select((s) => s.generatedDates),
        ) ??
        [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.selectedDates != dates) {
        _controller.selectedDates = dates;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_listEqualsDates(_controller.selectedDates, initialSelected)) {
        _controller.selectedDates = initialSelected;
      }
    });
    return dailyService
        ? IgnorePointer(
            ignoring: employeesSelected, // ⛔ Disable when selected
            child: Opacity(
              opacity: employeesSelected ? 0.4 : 1.0,
              child: DateFormField(
                initialDate: DateFormat('yyyy-MM-dd').parse(selectedDateState),
                onDateSelected: (dt) {
                  final formatted = DateFormat('yyyy-MM-dd').format(dt);
                  ref
                      .read(availabilityControllerProvider.notifier)
                      .selectDate(formatted);
                },
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date", style: Theme.of(context).textTheme.displayMedium),
              16.verticalSpace,
              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.multiple,
                controller: _controller,
                enablePastDates: false,
                // initialSelectedDates: ref.watch(
                //   availabilityControllerProvider.select((s) => [
                //     ...?s.assignedDates,
                //     ...ref.read(availabilityControllerProvider.notifier).remainingVisits
                //   ]),
                // ),
                initialSelectedDates: initialSelected,

                // initialSelectedDates: remaining,

                //  dates,
                showNavigationArrow: true,

                monthViewSettings: DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                ),

                selectionColor: AppColors.primary,
                todayHighlightColor: AppColors.primary,
                backgroundColor: Colors.white,
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: AppColors.disabledButtonBackground,
                ),
                selectableDayPredicate: (date) {
                  // disable already assigned dates (they are shown but not selectable)
                  final isAssigned = assigned.any(
                    (a) =>
                        a.year == date.year &&
                        a.month == date.month &&
                        a.day == date.day,
                  );
                  return !isAssigned;
                },
                onSelectionChanged: (arg) {
                  if (arg.value is List<DateTime>) {
                    ctrl.updateManualSelection(arg.value);
                  }
                    // ref
                    //   .read(availabilityControllerProvider.notifier)
                    //   .selectDate(arg.value);
                },
              ),
            ],
          );
  }

  bool _listEqualsDates(List? a, List? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      final da = a[i] as DateTime;
      final db = b[i] as DateTime;
      if (da.year != db.year || da.month != db.month || da.day != db.day)
        return false;
    }
    return true;
  }
}