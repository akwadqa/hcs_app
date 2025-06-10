// home_repository.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/Customer/data/models/add_cutomer_mdoel.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'availability_repository.g.dart';

@Riverpod(keepAlive: true)
AvailabilityRepository availabilityRepository(Ref ref) =>
    AvailabilityRepository(ref.watch(networkServiceProvider()));

class AvailabilityRepository {
  final NetworkService _networkService;

  AvailabilityRepository(this._networkService);

  Future<bool> addCustomer({required AddCustomerParams params}) async {
    var formData = FormData.fromMap({
      'customer_type': params.customerType,
      'customer_name': params.customerName,
      'customer_qid': params.customerQid,
      'customer_phone': params.customerPhone,
    });
    final response = await _networkService.post(
      ApiConstance.addCustomers,
      formData,
    );

    // final data = json.encode(response.data);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.message ?? 'Failed to Add Customers');
    }
  }

  Future<CustomersModel> getCustomers({required int page}) async {
    final response = await _networkService.get(
      ApiConstance.getCustomers(page.toString()),
    );
    // final data = json.encode(response.data);

    if (response.statusCode == 200) {
      final jsonString = json.encode(response.data);
      return customersModelFromJson(jsonString);
    } else {
      throw Exception(response.message ?? 'Failed to Get Customers');
    }
  }
}
