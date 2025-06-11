// home_repository.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/Customer/data/models/add_cutomer_mdoel.dart';
import 'package:hcs/features/Home/Customer/data/models/customers_model.dart';
import 'package:hcs/features/Home/Employees/data/models/employees_model.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employees_repository.g.dart';

@Riverpod(keepAlive: true)
EmployeesRepository employeesRepository(Ref ref) =>
    EmployeesRepository(ref.watch(networkServiceProvider()));

class EmployeesRepository {
  final NetworkService _networkService;

  EmployeesRepository(this._networkService);

  Future<Employees> getEmployees({required int page}) async {
    final response = await _networkService.get(
      ApiConstance.getEmployees(
        serviceType: 'Daily',
        date: '16-06-2025',
        shift: 'Full Day',
        employeeName: null,
        page: page.toString(),
      ),
    );
    // final data = json.encode(response.data);

    if (response.statusCode == 200) {
      // final jsonString = json.encode(response.data);
      return Employees.fromJson(response.data);
    } else {
      throw Exception(response.message ?? 'Failed to Get Employees');
    }
  }
}
