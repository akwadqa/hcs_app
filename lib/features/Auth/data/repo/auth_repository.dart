import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Auth/data/models/login_response_model.dart';
import 'package:hcs/features/Auth/data/models/register_response_model.dart';
import 'package:hcs/features/Auth/data/models/login_params.dart';
import 'package:hcs/features/Auth/data/models/register_params.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(ref.watch(networkServiceProvider()));

class AuthRepository {
  final NetworkService _networkService;

  AuthRepository(this._networkService);

  // /// Handle API response and only allow access to message and status_code
  // Future<String> _handleAuthResponse(Map<String, dynamic> responseData) async {
  //   final int? statusCode = responseData['status_code'];
  //   final String? message = responseData['message'];

  //   if (statusCode == 200) {
  //     return message ?? "";
  //   } else {
  //     throw Exception(message ?? "An unknown error occurred");
  //   }
  // }

  /// Login API request
  Future<String> login(LoginParams params) async {
    var formData = FormData.fromMap({
      'email': params.email,
      'password': params.pass,
    });

    final response = await _networkService.post(
      ApiConstance.loginPath,
      formData,
    );

    final data = json.encode(response.data);
    if (response.statusCode == 200) {
      return loginResponseFromJson(data).data.token;
    } else {
      throw Exception(response.message ?? "An unknown error occurred");
    }
    // return await _handleAuthResponse(response.data);
  }

  /// Signup API request
  Future<String> signup(RegisterParams params) async {
    var dataMap = <String, dynamic>{
      'name': params.name,
      'mobile_no': params.mobileNo,
      'email': params.email,
      'password': params.pass,
      'action': params.action == true ? "individual" : "company",
      // 'business_name': params.action == false ? params.businessName : null,
      // 'cr_number': params.action == false ? params.crNumber : null,
    };

    if (!params.action) dataMap['business_name'] = params.businessName;
    if (!params.action) dataMap['cr_number'] = params.crNumber;

    debugPrint("registeration API params : ${dataMap.toString()}");

    var formData = FormData.fromMap(dataMap);

    // var formData = FormData.fromMap({
    //   'name': params.name,
    //   'mobile_no': params.mobileNo,
    //   'email': params.email,
    //   'password': params.pass,
    //   'action': params.action == true ? "individual" : "company",
    //   if (!params.action) 'business_name': params.businessName,
    //   if (!params.action) 'cr_number': params.crNumber
    // });

    final response = await _networkService.post(
      ApiConstance.register,
      formData,
    );
    final data = json.encode(response.data);
    if (response.statusCode == 200) {
      return registerResponseFromJson(data).data.token;
    } else {
      throw Exception(response.message ?? "An unknown error occurred");
    }
    // return await _handleAuthResponse(response.data);
  }
}
