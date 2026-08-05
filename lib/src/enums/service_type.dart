enum ServiceType {
  onCall,
  packages,
  deepClean,
  maintenance,
  //
  home,
  myOrders,
  settings,
}

String serviceTypeToString(ServiceType serviceType) {
  switch (serviceType) {
    case ServiceType.onCall:
      return 'On Call';
    case ServiceType.packages:
      return 'Packages';
    case ServiceType.deepClean:
      return 'Deep Clean';
    case ServiceType.maintenance:
      return 'Maintenance';
    case ServiceType.home:
      return 'High Class Services';
    case ServiceType.myOrders:
      return 'My Orders';
    case ServiceType.settings:
      return 'Settings';
  }
}

ServiceType stringToServiceType(String string) {
  switch (string) {
    case 'On Call':
      return ServiceType.onCall;
    case 'Packages':
      return ServiceType.packages;
    case 'Deep Clean':
      return ServiceType.deepClean;
    case 'Maintenance':
      return ServiceType.maintenance;
    case 'High Class Services':
      return ServiceType.home;
    case 'My Orders':
      return ServiceType.myOrders;
    case 'Settings':
      return ServiceType.settings;
    default:
      return ServiceType.home;
  }
}

enum ShiftType { morning, evening, fullDay, overTime, partTime }

String shiftTypeToString(ShiftType shiftType) {
  switch (shiftType) {
    case ShiftType.morning:
      return 'Morning Shift';
    case ShiftType.evening:
      return 'Evening Shift';
    case ShiftType.fullDay:
      return 'Full Day';
    case ShiftType.overTime:
      return 'OverTime';
    case ShiftType.partTime:
      return 'Part Time';
  }
}

ShiftType stringToShiftType(String string) {
  switch (string) {
    case 'Morning':
      return ShiftType.morning;
    case 'Evening':
      return ShiftType.evening;
    case 'Full Day':
      return ShiftType.fullDay;
    case 'Part Time':
      return ShiftType.partTime;
    case 'Overtime' || 'Over time' || 'Over Time':
      return ShiftType.overTime;
    default:
      return ShiftType.fullDay;
  }
}

enum ServiceCategory { onCall, stayIn, company, flexible }

String serviceCategoryToString(ServiceCategory serviceCategory) {
  switch (serviceCategory) {
    case ServiceCategory.onCall:
      return 'on Call';
    case ServiceCategory.stayIn:
      return 'Stay - In';
    case ServiceCategory.company:
      return 'Company';
    case ServiceCategory.flexible:
      return 'Flexible';
  }
}

//Payment Enums
enum PaymentMethod { skipCash, cash }

String paymentMethodToString(PaymentMethod paymentMethod) {
  switch (paymentMethod) {
    case PaymentMethod.skipCash:
      return 'SkipCash';
    case PaymentMethod.cash:
      return 'Cash';
  }
}

/// A "service items" flow (Deep Clean or Maintenance).
enum HomeServiceMode {
  deepClean(
    title: 'Deep Clean',
    apiServiceType: 'Home Cleaning Services', // /service_items?service_type=...
    orderServiceType: 'Deep Clean', // create_service_order body
    showQtyField: false,
  ),
  maintenance(
    title: 'Maintenance',
    apiServiceType: 'Maintenance',
    orderServiceType: 'Maintenance',
    showQtyField: true, // Number of devices (ACs)
  );

  final String title;
  final String apiServiceType;
  final String orderServiceType;
  final bool showQtyField;

  const HomeServiceMode({
    required this.title,
    required this.apiServiceType,
    required this.orderServiceType,
    required this.showQtyField,
  });
 static HomeServiceMode fromSelectedServiceType(String? selected) {
    switch (selected) {
      case 'Maintenance':
        return HomeServiceMode.maintenance;
      case 'Deep Clean':
      default:
        return HomeServiceMode.deepClean;
    }
  }
  static HomeServiceMode fromServiceType(ServiceType s) =>
      s == ServiceType.maintenance
          ? HomeServiceMode.maintenance
          : HomeServiceMode.deepClean;
}
