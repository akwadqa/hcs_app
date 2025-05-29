// home_repository.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/data/models/credits_model.dart';
import 'package:hcs/features/Home/data/models/home_block_model.dart';
import 'package:hcs/src/constants/api_constance.dart';
import 'package:hcs/src/network/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) =>
    HomeRepository(ref.watch(networkServiceProvider()));

class HomeRepository {
  final NetworkService _networkService;

  HomeRepository(this._networkService);

  Future<HomeBlockModel> getHomeBlocks() async {
    final response = await _networkService.get(ApiConstance.home);
    // final data = json.encode(response.data);

    if (response.statusCode == 200) {
      return HomeBlockModel.fromJson(response.data);
    } else {
      throw Exception(response.message ?? 'Failed to load home blocks');
    }
  }

  Future<CreditsModel> fetchCreditsByID({
    required int page,
    required String itemGroupId,
  }) async {
    final response = await _networkService.get(
      ApiConstance.getCreditsByID(page.toString(), itemGroupId),
    );
    // final data = json.encode(response.data);

    if (response.statusCode == 200) {
      return CreditsModel.fromJson(response.data);
    } else {
      throw Exception(response.message ?? 'Failed to load home blocks');
    }
  }
}
