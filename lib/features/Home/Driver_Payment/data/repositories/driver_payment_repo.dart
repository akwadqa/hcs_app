import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_payment_repo.g.dart';

@Riverpod(keepAlive: true)
DriverPaymentRepository driverPaymentRepository(Ref ref) =>
    DriverPaymentRepository(ref.watch(networkServiceProvider()));

class DriverPaymentRepository {
  final NetworkService _networkService;

  DriverPaymentRepository(this._networkService);

  Future<Drivers> getDrivers({required int page}) async {
    final response = await _networkService.get(
      ApiConstance.getDrivers(page.toString()),
    );

    if (response.statusCode == 200) {
      return Drivers.fromJson(response.data);
    } else {
      throw Exception(response.message ?? 'Failed to Get Drivers');
    }
  }
}
