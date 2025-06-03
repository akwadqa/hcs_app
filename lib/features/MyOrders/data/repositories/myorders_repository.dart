// home_repository.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/data/models/customers_model.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'myorders_repository.g.dart';

@Riverpod(keepAlive: true)
MyOrdersRepository myOrdersRepository(Ref ref) =>
    MyOrdersRepository(ref.watch(networkServiceProvider()));

class MyOrdersRepository {
  final NetworkService _networkService;

  MyOrdersRepository(this._networkService);

  // Future<HomeBlockModel> getHomeBlocks() async {
  //   final response = await _networkService.get(ApiConstance.home);
  //   // final data = json.encode(response.data);

  //   if (response.statusCode == 200) {
  //     return HomeBlockModel.fromJson(response.data);
  //   } else {
  //     throw Exception(response.message ?? 'Failed to load home blocks');
  //   }
  // }

  Future<CustomersModel> fetchCreditsByID({
    required int page,
  }) async {
    final response = await _networkService.get(
      ApiConstance.getCustomers(page.toString()),
    );
    // final data = json.encode(response.data);

    if (response.statusCode == 200) {
      return customersModelFromJson(response.data);
    } else {
      throw Exception(response.message ?? 'Failed to load home blocks');
    }
  }
}
