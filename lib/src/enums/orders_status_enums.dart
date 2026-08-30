import 'shift_type_enum.dart';

class OrderFilter {
  final OrderStatus? status;
  final ShiftTypeEnum? shiftType;

  OrderFilter({this.status, this.shiftType});
}

enum OrderStatus {
  all,
  completed,
  pendingOutstanding,
  cancelled,
  closed,
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.all:
        return "All Orders";
      case OrderStatus.completed:
        return "Completed";
      case OrderStatus.pendingOutstanding:
        return "Pending for Outstanding Balance";
      case OrderStatus.cancelled:
        return "Cancelled";
      case OrderStatus.closed:
        return "Closed";
    }
  }

  /// what you return to API if needed
  String get apiValue {
    switch (this) {
      case OrderStatus.all:
        return "all";
      case OrderStatus.completed:
        return "Completed";
      case OrderStatus.pendingOutstanding:
        return "Pending for Outstanding Balance";
      case OrderStatus.cancelled:
        return "Cancelled";
              case OrderStatus.closed:
        return "Closed";
    }
  }

  /// Short label for UI (optional)
  String get shortLabel {
    switch (this) {
      case OrderStatus.pendingOutstanding:
        return "POB";
      default:
        return label;
    }
  }
}
extension StatusHandler on String{
  String get status{
    switch (this){
      case "Pending for Outstanding Balance":
      return "POB";
       default:
        return this;
    }
  }
}
