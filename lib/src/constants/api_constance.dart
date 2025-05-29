class ApiConstance {
  static const String baseUrl = "https://mgs.akwad.qa/api/method";

  static const String baseImageUrl = 'https://mgs.akwad.qa/';
  static String imageUrl(String? path) {
    if (path != null) {
      return '$baseImageUrl$path';
    } else {
      return 'https://picsum.photos/600/400?random=1';
    }
  }

  ////////////////// *  Register   //////////////////
  static const String register = '$baseUrl/mgs.api.authentication.register';

  ////////////////// *  Login   /////////////////////
  static const String loginPath = '$baseUrl/mgs.api.authentication.login';

  ////////////////// *  Home   /////////////////////
  static const String home = '$baseUrl/jocards.mgs_api.home_block.home_blocks';

  ////////////////// *  Credit   /////////////////////
  static String getCreditsByID(String page, String itemGroupId) =>
      '$baseUrl/jocards.mgs_api.item_group.item_group_items?page=$page&item_group_id=$itemGroupId';

  ////////////////// *  Search   /////////////////////
  static String searchItemGroupByID(String? itemGroupId) {
    if (itemGroupId != null && itemGroupId.isNotEmpty) {
      return '$baseUrl/jocards.mgs_api.item_group.item_groups?item_group_id=$itemGroupId';
    } else {
      return '$baseUrl/jocards.mgs_api.item_group.item_groups';
    }
  }

  ////////////////// *  Profile   /////////////////////
  static const String profile = '$baseUrl/jocards.mgs_api.profile.profile';
}
