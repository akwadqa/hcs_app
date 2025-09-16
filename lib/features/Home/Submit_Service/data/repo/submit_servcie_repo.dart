import 'package:dio/dio.dart';
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

  Future<bool> submitService(SubmitServiceParams data) async {

try {
   final  response = await _networkService.post(
      ApiConstance.submitService(),
      data.toMap(),
    );
    final int? statusCode = response.data['status_code'];

    if (statusCode != 200) {
      return false;
    }
    return true;
  
} catch (e) {
      throw AppException(e ?? 'Failed to Get Drivers');
  
}
   
}}
