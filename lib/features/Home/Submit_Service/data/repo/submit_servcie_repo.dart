import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/Submit_Service/data/models/submit_service_params.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/exception/dio_exceptions.dart';
import 'package:hcs/src/network/services/dio_client.dart';
import 'package:hcs/src/network/services/network_service.dart';
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
      /// 🔥 Pretty-print the full request body
      debugPrint("==== SUBMIT SERVICE BODY ====");
      debugPrint(const JsonEncoder.withIndent("  ").convert(data.toMap()));
      debugPrint("================================");

      final response = await _networkService.post(
        ApiConstance.submitService(),
     data:    data.toMap(),
      );
      final int? statusCode = response.data['status_code'];

      if (statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
