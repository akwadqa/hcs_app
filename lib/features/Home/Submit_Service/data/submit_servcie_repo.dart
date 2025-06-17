import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<bool> submitService(SubmitServiceParams params) async {
    // var dataMap = <String, dynamic>{
    //   'customer': params.customer,
    //   'driver': params.driver,
    //   'date': params.date,
    //   'service_type': params.serviceType,
    //   'shift_type': params.shiftType,
    //   'payment_method': params.paymentMethod,
    //   // Stringify list of employee maps
    //   'employees': params.employees.map((e) => e.toJson()).toList().toString(),
    // };

    // if (params.serviceType != 'Daily') {
    //   dataMap['days'] = params.days?.toString(); // ensure it's stringified
    // }

    // var formData = FormData.fromMap(dataMap);
    debugPrint("htr ${params.toMap().toString()}");

    final response = await _networkService.post(
      ApiConstance.submitService(),
      params.toMap(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.message ?? 'Failed to Get Drivers');
    }
  }
}
