class ApiConstance {
  static const String baseUrl = "https://highclass.akwad.qa/api/method";
  static const String baseDomain = "highclass";
  static const String baseImageUrl = 'https://$baseDomain.akwad.qa/';

  static String imageUrl(String? path) {
    if (path != null) {
      return '$baseImageUrl$path';
    } else {
      return 'https://picsum.photos/600/400?random=1';
    }
  }

  ////////////////// *  Login   /////////////////////
  static const String loginPath =
      '$baseUrl/$baseDomain.api.authentication.login';

  ////////////////// *  Customers   /////////////////////
  static String getCustomers(String page) =>
      '$baseUrl/$baseDomain.api.customer.customers?page=$page&limit=10';
  static String addCustomers = '$baseUrl/$baseDomain.api.customer.customer';

  ////////////////// *  Availabillty   /////////////////////
  static String getPackages =
      '$baseUrl/$baseDomain.api.service_type.service_types';

  ////////////////// *  Employees   /////////////////////
  static String getEmployees({
    required String serviceType,
    required String date,
    required List<String> days,
    required String shift,
    required String? serviceCategory,
    required String? employeeName,
    required String page,
  }) {
    print(
      'fagwaha $baseUrl/$baseDomain.api.employee.employees?service_type=$serviceType&date=$date&shift=$shift&designation=&service_category=$serviceCategory&days=$days&$employeeName&page=$page&limit=5',
    );
    return '$baseUrl/$baseDomain.api.employee.employees?service_type=$serviceType&date=$date&shift=$shift&designation=&service_category=$serviceCategory&days=$days&$employeeName&page=$page&limit=5';
  }

  ////////////////// *  Drivers   /////////////////////
  static String getDrivers(String page) =>
      '$baseUrl/$baseDomain.api.driver.drivers?page=$page&limit=10';

  static String getDiscoutType() =>
      '$baseUrl/$baseDomain.api.discount_type.discount_types';
  ////////////////// *  SubmitService   /////////////////////
  static String submitService() =>
      '$baseUrl/$baseDomain.api.service_order.service_order';
}
