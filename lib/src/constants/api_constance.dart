class ApiConstance {
  static const String devBaseUrl = "https://hcs.akwad.qa/api/method";
  static const String prodBaseUrl = "https://erp.hcs.qa/api/method";
  static const String baseUrl = prodBaseUrl;
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
  static String forgotPassword(String email) =>
      '$baseUrl/frappe.core.doctype.user.user.reset_password?user=$email';
  static String getVersion = '$baseUrl/highclass.api.api.app_version';

  ////////////////// *  Customers   /////////////////////
  ///
  static String getCustomerBalance({required String customerId}) =>
      '$baseUrl/$baseDomain.api.customer.get_customer_balances?customer=$customerId';
  static String getCustomers({
    required String page,
    required String customerName,
  }) =>
      '$baseUrl/$baseDomain.api.customer.customers?page=$page&limit=100&search=$customerName';
  static String addCustomers = '$baseUrl/$baseDomain.api.customer.customer';

  ////////////////// *  Availabillty   /////////////////////
  static String getPackages =
      '$baseUrl/$baseDomain.api.service_type.service_types';

  //////////////////* Report //////////////////////////
  static String getReport =
      '$baseUrl/$baseDomain.api.service_order.service_orders';

  ////////////////// *  Employees   /////////////////////

  static String getEmployees({
    required String serviceType,
    required String date,
    required List<String> days,
    required String shift,
    String? serviceCategory,
    String? employeeName,
    String? overTimeHours,
    required String page,
  }) {
    // return 'https://highclass.akwad.qa/api/method/highclass.api.employee.employees?service_type=Flexible – 8 visits/month&date=2025-06-28&shift=Full Day&designation=&service_category=Company&days=["monday", "wednesday"]&page=1&limit=10';
    final Map<String, String> queryParams = {
      'service_type': serviceType,
      'date': date,
      'shift': shift,
      if (overTimeHours != null) "overtime_hours": overTimeHours,
      // 'designation': '',
      'page': page,
      'limit': '10',
    };

    if (serviceCategory != null &&
        serviceCategory.isNotEmpty &&
        overTimeHours == null) {
      queryParams['service_category'] = serviceCategory;
    }

    if (days.isNotEmpty) {
      queryParams['days'] = days.isEmpty ? '' : '$days';
    }

    if (employeeName != null && employeeName.isNotEmpty) {
      queryParams['employee_name'] = employeeName;
    }

    final uri = Uri.parse(
      '$baseUrl/$baseDomain.api.employee.employees',
    ).replace(queryParameters: queryParams);

    // print('Request URL: $uri');

    return uri.toString();
  }

  ////////////////// *  Drivers   /////////////////////
  static String getDrivers(String page) =>
      '$baseUrl/$baseDomain.api.driver.drivers?page=$page&limit=25';

  static String getDiscoutType() =>
      '$baseUrl/$baseDomain.api.discount_type.discount_types';
  ////////////////// *  SubmitService   /////////////////////
  static String submitService() =>
      '$baseUrl/$baseDomain.api.service_order.create_service_order';

  //////////////////! *  MyOrders Services   /////////////////////
  static String myServicesOrders() =>
      '$baseUrl/$baseDomain.api.service_order.service_orders';
  // static String myServicesOrders({
  //   required String page,
  //   required String status,
  //   required String orderSearched,
  // }) =>
  //     '$baseUrl/$baseDomain.api.service_order.service_orders?page=$page&limit=10&status=$status&search=$orderSearched&action=supervisor';

  // static String getServiceOrderDetails({required String serviceOrderId}) =>
  //     '$baseUrl/$baseDomain.api.service_order.service_order_details?service_order_id=$serviceOrderId';

  static String getServiceOrderDetails =
      '$baseUrl/$baseDomain.api.service_order.service_order_details';

  //? This for appointment :
  static String appontmentsLogs() =>
      '$baseUrl/$baseDomain.api.staff_appointment_log.staff_appointment_logs?limit=10';

  static String orderCancelltion =
      '$baseUrl/$baseDomain.api.service_order.cancel_service_order';
  static String getServiceItems({required String serviceType}) =>
      '$baseUrl/$baseDomain.api.service_type.service_items?service_type=$serviceType';
  ////////////////// *  DeepClean   /////////////////////
  static String getDeepCleanServices =
      '$baseUrl/$baseDomain.api.service_type.service_items';

  static String createDeepCleanOrder =
      '$baseUrl/$baseDomain.api.deep_clean.create_order';
}
