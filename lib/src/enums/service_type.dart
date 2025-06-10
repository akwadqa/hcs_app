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
