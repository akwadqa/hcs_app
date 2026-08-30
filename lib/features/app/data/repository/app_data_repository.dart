import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hcs/features/app/data/remote/app_data_source.dart';
import 'package:hcs/features/app/domain/version_update.dart';
import 'package:hcs/src/constants/api/api_response.dart';
import 'package:hcs/src/network/exception/dio_exceptions.dart';
import 'package:hcs/src/network/services/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_data_repository.g.dart';

@Riverpod(keepAlive: true)
AppDataRepository appDataRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  return AppDataRepository(AppDataSource(networkService));
}

class AppDataRepository {
  final AppDataSource _remoteDataSource;

  AppDataRepository(this._remoteDataSource);

  Future<ApiResponse<VersionUpdate>> getAppVersion() async {
    final response = await _remoteDataSource.getAppVersion();

    if (response.status == 200) {
      return response;
    }

    throw AppException(response.message);
  }
}
