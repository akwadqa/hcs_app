abstract class EndPoints {
  static const String homeApi = 'HomepageApi';

  // 🟦 AUTH

  static const String registerApi = 'ehtezam.api.authentication.register';
  static const String loginApi = 'ehtezam.api.authentication.send_otp';
  static const String verificationCodeApi =
      'ehtezam.api.authentication.verify_otp';
  static const String serviceTypes = 'ehtezam.api.service_type.service_types';

  // 🟩 ORDER
  static const String respondToOffer =
      'ehtezam.api.quick_order.respond_to_offer';

  // 🟩 UPDATE ORDER STATUS
  static const String updateOrderStatus =
      'ehtezam.api.quick_order.update_quick_order_status';
  static const String setOfferPriceApi =
      'ehtezam.api.quick_order.set_offer_price';

  // 🟪 ORDER INFO
  static const String orderDetailsApi =
      'ehtezam.api.quick_order.get_quick_order_details';

  // 🟪 ALL ORDEERS NOTIFICATIONS
  static const String ordersNotificationsApi =
      'ehtezam.api.quick_order.get_quick_order_offer_details';

  // 🟨 Profile
  static const String profileDataApi = 'ehtezam.api.profile.profile';
  static const String ratingApi = 'ehtezam.api.review.passenger_review';
  static const String profitsDetailsApi = 'ehtezam.api.driver_earnings.earnings';
  static const String reviewsListApi = 'ehtezam.api.review.reviews';
    static const String withdrawalRequestApi =
      'ehtezam.api.digital_wallet.digital_wallet_request';
    static const String getWithdrawalRequestApi =
      'ehtezam.api.digital_wallet.get_digital_wallet_requests';
    static const String walletHistoryDataApi =
      'ehtezam.api.digital_wallet.digital_wallet_history';
  static const String settingsApi = 'ehtezam.api.api.get_ehtezam_details';
      
  static const String profitsApi = 'ehtezam.api.driver_earnings.earnings_chart';

  // ! FCM TOKEN
  static const String sendFcmToken = 'fcm_frappe.api.device_token';
}
