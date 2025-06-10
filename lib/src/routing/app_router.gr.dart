// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:hcs/features/app/intro_screen.dart' as _i5;
import 'package:hcs/features/app/main_screen.dart' as _i7;
import 'package:hcs/features/Auth/presentation/pages/login_screen.dart' as _i6;
import 'package:hcs/features/Home/Availability/presentation/pages/service_config_screen.dart'
    as _i10;
import 'package:hcs/features/Home/Customer/presentation/pages/customer_screen.dart'
    as _i1;
import 'package:hcs/features/Home/Customer/presentation/pages/employees_screen.dart'
    as _i2;
import 'package:hcs/features/Home/Customer/presentation/pages/home_content.dart'
    as _i3;
import 'package:hcs/features/Home/Customer/presentation/pages/home_screen.dart'
    as _i4;
import 'package:hcs/features/MyOrders/presentation/pages/myorders_content.dart'
    as _i8;
import 'package:hcs/features/MyOrders/presentation/pages/myorders_screen.dart'
    as _i9;
import 'package:hcs/features/settings/presentation/pages/settings_content_screen.dart'
    as _i11;
import 'package:hcs/features/settings/presentation/pages/settings_screen.dart'
    as _i12;
import 'package:hcs/src/enums/service_type.dart' as _i15;

/// generated route for
/// [_i1.CustomerScreen]
class CustomerRoute extends _i13.PageRouteInfo<CustomerRouteArgs> {
  CustomerRoute({
    _i14.Key? key,
    required _i15.ServiceType serviceType,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         CustomerRoute.name,
         args: CustomerRouteArgs(key: key, serviceType: serviceType),
         initialChildren: children,
       );

  static const String name = 'CustomerRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerRouteArgs>();
      return _i1.CustomerScreen(key: args.key, serviceType: args.serviceType);
    },
  );
}

class CustomerRouteArgs {
  const CustomerRouteArgs({this.key, required this.serviceType});

  final _i14.Key? key;

  final _i15.ServiceType serviceType;

  @override
  String toString() {
    return 'CustomerRouteArgs{key: $key, serviceType: $serviceType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerRouteArgs) return false;
    return key == other.key && serviceType == other.serviceType;
  }

  @override
  int get hashCode => key.hashCode ^ serviceType.hashCode;
}

/// generated route for
/// [_i2.EmployeesScreen]
class EmployeesRoute extends _i13.PageRouteInfo<EmployeesRouteArgs> {
  EmployeesRoute({
    _i14.Key? key,
    required _i15.ServiceType serviceType,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         EmployeesRoute.name,
         args: EmployeesRouteArgs(key: key, serviceType: serviceType),
         initialChildren: children,
       );

  static const String name = 'EmployeesRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployeesRouteArgs>();
      return _i2.EmployeesScreen(key: args.key, serviceType: args.serviceType);
    },
  );
}

class EmployeesRouteArgs {
  const EmployeesRouteArgs({this.key, required this.serviceType});

  final _i14.Key? key;

  final _i15.ServiceType serviceType;

  @override
  String toString() {
    return 'EmployeesRouteArgs{key: $key, serviceType: $serviceType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmployeesRouteArgs) return false;
    return key == other.key && serviceType == other.serviceType;
  }

  @override
  int get hashCode => key.hashCode ^ serviceType.hashCode;
}

/// generated route for
/// [_i3.HomeContentScreen]
class HomeContentRoute extends _i13.PageRouteInfo<void> {
  const HomeContentRoute({List<_i13.PageRouteInfo>? children})
    : super(HomeContentRoute.name, initialChildren: children);

  static const String name = 'HomeContentRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeContentScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.IntroScreen]
class IntroRoute extends _i13.PageRouteInfo<void> {
  const IntroRoute({List<_i13.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.IntroScreen();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginScreen();
    },
  );
}

/// generated route for
/// [_i7.MainScreen]
class MainRoute extends _i13.PageRouteInfo<void> {
  const MainRoute({List<_i13.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.MainScreen();
    },
  );
}

/// generated route for
/// [_i8.MyOrdersContentScreen]
class MyOrdersContentRoute extends _i13.PageRouteInfo<void> {
  const MyOrdersContentRoute({List<_i13.PageRouteInfo>? children})
    : super(MyOrdersContentRoute.name, initialChildren: children);

  static const String name = 'MyOrdersContentRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.MyOrdersContentScreen();
    },
  );
}

/// generated route for
/// [_i9.MyOrdersScreen]
class MyOrdersRoute extends _i13.PageRouteInfo<void> {
  const MyOrdersRoute({List<_i13.PageRouteInfo>? children})
    : super(MyOrdersRoute.name, initialChildren: children);

  static const String name = 'MyOrdersRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.MyOrdersScreen();
    },
  );
}

/// generated route for
/// [_i10.ServiceConfigurationScreen]
class ServiceConfigurationRoute
    extends _i13.PageRouteInfo<ServiceConfigurationRouteArgs> {
  ServiceConfigurationRoute({
    _i14.Key? key,
    required _i15.ServiceType serviceType,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         ServiceConfigurationRoute.name,
         args: ServiceConfigurationRouteArgs(
           key: key,
           serviceType: serviceType,
         ),
         initialChildren: children,
       );

  static const String name = 'ServiceConfigurationRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ServiceConfigurationRouteArgs>();
      return _i10.ServiceConfigurationScreen(
        key: args.key,
        serviceType: args.serviceType,
      );
    },
  );
}

class ServiceConfigurationRouteArgs {
  const ServiceConfigurationRouteArgs({this.key, required this.serviceType});

  final _i14.Key? key;

  final _i15.ServiceType serviceType;

  @override
  String toString() {
    return 'ServiceConfigurationRouteArgs{key: $key, serviceType: $serviceType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ServiceConfigurationRouteArgs) return false;
    return key == other.key && serviceType == other.serviceType;
  }

  @override
  int get hashCode => key.hashCode ^ serviceType.hashCode;
}

/// generated route for
/// [_i11.SettingsContentScreen]
class SettingsContentRoute extends _i13.PageRouteInfo<void> {
  const SettingsContentRoute({List<_i13.PageRouteInfo>? children})
    : super(SettingsContentRoute.name, initialChildren: children);

  static const String name = 'SettingsContentRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingsContentScreen();
    },
  );
}

/// generated route for
/// [_i12.SettingsScreen]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute({List<_i13.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsScreen();
    },
  );
}
