abstract class SocketEvents {

// 🟦 DRIVER LOCATION 

  static const String updateLocation = 'update_driver_location';
  static const String driverOnOrderLocation = 'driver_location';

// 🟩 ORDER 

  static const String newOrder = 'new_order';
    static const String orderAccepted = 'order_accepted';
  static const String orderDeclined = 'order_declined';
  static const String orderCancelled = 'order_cancelled';
  static const String orderCompleted = 'order_completed';
  static const String orderStatusUpdate = 'order_status_update';
  static const String chatMessage = 'chat_message';

    // Notification events
  static const String notification = 'notification';
  static const String notificationRead = 'notification_read';
  // Order events


}
