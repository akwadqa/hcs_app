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

enum ShiftType { morning, evening, fullDay }

String shiftTypeToString(ShiftType shiftType) {
  switch (shiftType) {
    case ShiftType.morning:
      return 'Morning';
    case ShiftType.evening:
      return 'Evening';
    case ShiftType.fullDay:
      return 'Full day';
  }
}

ShiftType stringToShiftType(String string) {
  switch (string) {
    case 'Morning':
      return ShiftType.morning;
    case 'Evening':
      return ShiftType.evening;
    case 'Full day':
      return ShiftType.fullDay;
    default:
      return ShiftType.fullDay;
  }
}

enum ServiceCategory { onCall, stayIn, company, packages }

String serviceCategoryToString(ServiceCategory serviceCategory) {
  switch (serviceCategory) {
    case ServiceCategory.onCall:
      return 'On Call';
    case ServiceCategory.stayIn:
      return 'Stay in';
    case ServiceCategory.company:
      return 'Company';
    case ServiceCategory.packages:
      return 'Packages';
  }
}

//Payment Enums
enum PaymentMethod { online, cash }

String paymentMethodToString(PaymentMethod paymentMethod) {
  switch (paymentMethod) {
    case PaymentMethod.online:
      return 'Online';
    case PaymentMethod.cash:
      return 'Cash';
  }
}
