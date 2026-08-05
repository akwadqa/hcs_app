

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/Home/deep_clean/data/deep_clean_remote_data_source.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/deep_clean_order_params.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/deep_clean_service_model.dart';
import 'package:hcs/features/Home/deep_clean/domain/models/service_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../src/network/network_service.dart';
part 'deep_clean_repository.g.dart';

@riverpod
DeepCleanRepository deepCleanRepository(Ref ref) {
  final network = ref.read(networkServiceProvider());
  return DeepCleanRepository(DeepCleanRemoteDataSource(network));
}
class DeepCleanRepository {
  final DeepCleanRemoteDataSource _remote;

  DeepCleanRepository(this._remote);

 Future<List<ServiceItemModel>> getServiceItems({
   required String serviceType,
  }) async {
    final res = await _remote.getServiceItems(serviceType: serviceType);
    if (!res.hasSucceeded) {
      throw Exception(res.message ?? 'Failed to load services');
    }
    return res.data ?? const [];
  }

  Future<void> createOrder(DeepCleanOrderParams params) async {
    final res = await _remote.createOrder(params);
    if (!res.hasSucceeded) {
      throw Exception(res.message ?? 'Failed to create order');
    }
  }
}