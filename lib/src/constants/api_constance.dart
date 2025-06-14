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
    required String shift,
    required String? serviceCategory,
    required String? employeeName,
    required String page,
  }) =>
      '$baseUrl/$baseDomain.api.employee.employees?service_type=$serviceType&date=$date&shift=$shift&designation=&service_category=$serviceCategory&days=&$employeeName&page=$page&limit=5';

  ////////////////// *  Drivers   /////////////////////
  static String getDrivers(String page) =>
      '$baseUrl/$baseDomain.api.driver.drivers?page=$page&limit=10';

  ////////////////// *  SubmitService   /////////////////////
  static String submitService() =>
      '$baseUrl/$baseDomain.api.service_order.service_order';

  ////////////////// *  Register   //////////////////
  // static const String register =
  //     '$baseUrl/$baseDomain.api.authentication.register';

  ////////////////// *  Home   /////////////////////
  // static const String home =
  //     '$baseUrl/${baseDomain}_api.home_block.home_blocks';

  ////////////////// *  Search   /////////////////////
  // static String searchItemGroupByID(String? itemGroupId) {
  //   if (itemGroupId != null && itemGroupId.isNotEmpty) {
  //     return '$baseUrl/jocards.${baseDomain}_api.item_group.item_groups?item_group_id=$itemGroupId';
  //   } else {
  //     return '$baseUrl/jocards.${baseDomain}_api.item_group.item_groups';
  //   }
  // }

  ////////////////// *  Profile   /////////////////////
  // static const String profile =
  //     '$baseUrl/jocards.${baseDomain}_api.profile.profile';
}
