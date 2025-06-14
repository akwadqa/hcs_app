import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/Driver_Payment/data/models/drivers_model.dart';
import 'package:hcs/features/Home/Submit_Service/data/models/submit_service_params.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submit_servcie_repo.g.dart';

@Riverpod(keepAlive: true)
SubmitServiceRepository submitServiceRepository(Ref ref) =>
    SubmitServiceRepository(ref.watch(networkServiceProvider()));

class SubmitServiceRepository {
  final NetworkService _networkService;

  SubmitServiceRepository(this._networkService);

  Future<Drivers> submitService(SubmitServiceParams params) async {
    var dataMap = <String, dynamic>{
      'customer': params.customer,
      'driver': params.driver,
      'date': params.date,
      'service_type': params.serviceType,
      'shift_type': params.shiftType,
      // 'days': params.days,
      'employees': params.employees,
      'payment_method': params.paymentMethod,
    };

    if (params.serviceType != 'Daily') dataMap['days'] = params.days;

    var formData = FormData.fromMap(dataMap);

    final response = await _networkService.post(
      ApiConstance.submitService(),
      formData,
    );

    if (response.statusCode == 200) {
      return Drivers.fromJson(response.data);
    } else {
      throw Exception(response.message ?? 'Failed to Get Drivers');
    }
  }
}
