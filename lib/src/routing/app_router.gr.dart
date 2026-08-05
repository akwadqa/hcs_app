// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;
import 'package:hcs/features/app/intro_screen.dart' as _i9;
import 'package:hcs/features/app/main_screen.dart' as _i11;
import 'package:hcs/features/Auth/presentation/pages/login_screen.dart' as _i10;
import 'package:hcs/features/Home/Availability/presentation/pages/days_selection_screen.dart'
    as _i3;
import 'package:hcs/features/Home/Availability/presentation/pages/service_config_screen.dart'
    as _i17;
import 'package:hcs/features/Home/Customer/presentation/pages/customer_screen.dart'
    as _i2;
import 'package:hcs/features/Home/Customer/presentation/pages/home_content.dart'
    as _i7;
import 'package:hcs/features/Home/Customer/presentation/pages/home_screen.dart'
    as _i8;
import 'package:hcs/features/Home/deep_clean/presentation/screen/deep_clean_screen.dart'
    as _i4;
import 'package:hcs/features/Home/deep_clean/presentation/screen/order_summary_screen.dart'
    as _i15;
import 'package:hcs/features/Home/deep_clean/presentation/screen/service_details_screen.dart'
    as _i18;
import 'package:hcs/features/Home/Driver_Payment/presentation/pages/driver_payment_screen.dart'
    as _i5;
import 'package:hcs/features/Home/Employees/presentation/pages/employees_screen.dart'
    as _i6;
import 'package:hcs/features/MyOrders/presentation/pages/appointment_screen.dart'
    as _i1;
import 'package:hcs/features/MyOrders/presentation/pages/myorders_content.dart'
    as _i12;
import 'package:hcs/features/MyOrders/presentation/pages/myorders_screen.dart'
    as _i13;
import 'package:hcs/features/MyOrders/presentation/pages/order_details_screen.dart'
    as _i14;
import 'package:hcs/features/report/presentation/pages/report_screen.dart'
    as _i16;
import 'package:hcs/features/settings/presentation/pages/settings_content_screen.dart'
    as _i19;
import 'package:hcs/features/settings/presentation/pages/settings_screen.dart'
    as _i20;
import 'package:hcs/src/enums/service_type.dart' as _i23;

/// generated route for
/// [_i1.AppoinmentScreen]
class AppoinmentRoute extends _i21.PageRouteInfo<AppoinmentRouteArgs> {
  AppoinmentRoute({
    _i22.Key? key,
    required String serviceOrderID,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         AppoinmentRoute.name,
         args: AppoinmentRouteArgs(key: key, serviceOrderID: serviceOrderID),
         initialChildren: children,
       );

  static const String name = 'AppoinmentRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppoinmentRouteArgs>();
      return _i1.AppoinmentScreen(
        key: args.key,
        serviceOrderID: args.serviceOrderID,
      );
    },
  );
}

class AppoinmentRouteArgs {
  const AppoinmentRouteArgs({this.key, required this.serviceOrderID});

  final _i22.Key? key;

  final String serviceOrderID;

  @override
  String toString() {
    return 'AppoinmentRouteArgs{key: $key, serviceOrderID: $serviceOrderID}';
  }
}

/// generated route for
/// [_i2.CustomerScreen]
class CustomerRoute extends _i21.PageRouteInfo<CustomerRouteArgs> {
  CustomerRoute({
    _i22.Key? key,
    required _i23.ServiceType serviceType,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         CustomerRoute.name,
         args: CustomerRouteArgs(key: key, serviceType: serviceType),
         initialChildren: children,
       );

  static const String name = 'CustomerRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerRouteArgs>();
      return _i2.CustomerScreen(key: args.key, serviceType: args.serviceType);
    },
  );
}

class CustomerRouteArgs {
  const CustomerRouteArgs({this.key, required this.serviceType});

  final _i22.Key? key;

  final _i23.ServiceType serviceType;

  @override
  String toString() {
    return 'CustomerRouteArgs{key: $key, serviceType: $serviceType}';
  }
}

/// generated route for
/// [_i3.DaysSelectionScreen]
class DaysSelectionRoute extends _i21.PageRouteInfo<void> {
  const DaysSelectionRoute({List<_i21.PageRouteInfo>? children})
    : super(DaysSelectionRoute.name, initialChildren: children);

  static const String name = 'DaysSelectionRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i3.DaysSelectionScreen();
    },
  );
}

/// generated route for
/// [_i4.DeepCleanScreen]
class DeepCleanRoute extends _i21.PageRouteInfo<void> {
  const DeepCleanRoute({List<_i21.PageRouteInfo>? children})
    : super(DeepCleanRoute.name, initialChildren: children);

  static const String name = 'DeepCleanRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i4.DeepCleanScreen();
    },
  );
}

/// generated route for
/// [_i5.DriverPaymentScreen]
class DriverPaymentRoute extends _i21.PageRouteInfo<void> {
  const DriverPaymentRoute({List<_i21.PageRouteInfo>? children})
    : super(DriverPaymentRoute.name, initialChildren: children);

  static const String name = 'DriverPaymentRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i5.DriverPaymentScreen();
    },
  );
}

/// generated route for
/// [_i6.EmployeesScreen]
class EmployeesRoute extends _i21.PageRouteInfo<void> {
  const EmployeesRoute({List<_i21.PageRouteInfo>? children})
    : super(EmployeesRoute.name, initialChildren: children);

  static const String name = 'EmployeesRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i6.EmployeesScreen();
    },
  );
}

/// generated route for
/// [_i7.HomeContentScreen]
class HomeContentRoute extends _i21.PageRouteInfo<void> {
  const HomeContentRoute({List<_i21.PageRouteInfo>? children})
    : super(HomeContentRoute.name, initialChildren: children);

  static const String name = 'HomeContentRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeContentScreen();
    },
  );
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i21.PageRouteInfo<void> {
  const HomeRoute({List<_i21.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i8.HomeScreen();
    },
  );
}

/// generated route for
/// [_i9.IntroScreen]
class IntroRoute extends _i21.PageRouteInfo<void> {
  const IntroRoute({List<_i21.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i9.IntroScreen();
    },
  );
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i21.PageRouteInfo<void> {
  const LoginRoute({List<_i21.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i10.LoginScreen();
    },
  );
}

/// generated route for
/// [_i11.MainScreen]
class MainRoute extends _i21.PageRouteInfo<void> {
  const MainRoute({List<_i21.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i11.MainScreen();
    },
  );
}

/// generated route for
/// [_i12.MyOrdersContentScreen]
class MyOrdersContentRoute extends _i21.PageRouteInfo<void> {
  const MyOrdersContentRoute({List<_i21.PageRouteInfo>? children})
    : super(MyOrdersContentRoute.name, initialChildren: children);

  static const String name = 'MyOrdersContentRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i12.MyOrdersContentScreen();
    },
  );
}

/// generated route for
/// [_i13.MyOrdersScreen]
class MyOrdersRoute extends _i21.PageRouteInfo<void> {
  const MyOrdersRoute({List<_i21.PageRouteInfo>? children})
    : super(MyOrdersRoute.name, initialChildren: children);

  static const String name = 'MyOrdersRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i13.MyOrdersScreen();
    },
  );
}

/// generated route for
/// [_i14.OrderDetailsScreen]
class OrderDetailsRoute extends _i21.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i22.Key? key,
    required String serviceOrderID,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         OrderDetailsRoute.name,
         args: OrderDetailsRouteArgs(key: key, serviceOrderID: serviceOrderID),
         initialChildren: children,
       );

  static const String name = 'OrderDetailsRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailsRouteArgs>();
      return _i14.OrderDetailsScreen(
        key: args.key,
        serviceOrderID: args.serviceOrderID,
      );
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({this.key, required this.serviceOrderID});

  final _i22.Key? key;

  final String serviceOrderID;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, serviceOrderID: $serviceOrderID}';
  }
}

/// generated route for
/// [_i15.OrderSummaryScreen]
class OrderSummaryRoute extends _i21.PageRouteInfo<void> {
  const OrderSummaryRoute({List<_i21.PageRouteInfo>? children})
    : super(OrderSummaryRoute.name, initialChildren: children);

  static const String name = 'OrderSummaryRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i15.OrderSummaryScreen();
    },
  );
}

/// generated route for
/// [_i16.ReportScreen]
class ReportRoute extends _i21.PageRouteInfo<void> {
  const ReportRoute({List<_i21.PageRouteInfo>? children})
    : super(ReportRoute.name, initialChildren: children);

  static const String name = 'ReportRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i16.ReportScreen();
    },
  );
}

/// generated route for
/// [_i17.ServiceConfigurationScreen]
class ServiceConfigurationRoute extends _i21.PageRouteInfo<void> {
  const ServiceConfigurationRoute({List<_i21.PageRouteInfo>? children})
    : super(ServiceConfigurationRoute.name, initialChildren: children);

  static const String name = 'ServiceConfigurationRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i17.ServiceConfigurationScreen();
    },
  );
}

/// generated route for
/// [_i18.ServiceDetailsScreen]
class ServiceDetailsRoute extends _i21.PageRouteInfo<void> {
  const ServiceDetailsRoute({List<_i21.PageRouteInfo>? children})
    : super(ServiceDetailsRoute.name, initialChildren: children);

  static const String name = 'ServiceDetailsRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i18.ServiceDetailsScreen();
    },
  );
}

/// generated route for
/// [_i19.SettingsContentScreen]
class SettingsContentRoute extends _i21.PageRouteInfo<void> {
  const SettingsContentRoute({List<_i21.PageRouteInfo>? children})
    : super(SettingsContentRoute.name, initialChildren: children);

  static const String name = 'SettingsContentRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i19.SettingsContentScreen();
    },
  );
}

/// generated route for
/// [_i20.SettingsScreen]
class SettingsRoute extends _i21.PageRouteInfo<void> {
  const SettingsRoute({List<_i21.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i20.SettingsScreen();
    },
  );
}
