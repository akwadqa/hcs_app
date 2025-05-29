import 'package:flutter/material.dart';
import 'package:hcs/features/Auth/application/auth_service.dart';
import 'package:hcs/features/Auth/data/models/login_params.dart';
import 'package:hcs/features/Auth/data/models/register_params.dart';
import 'package:hcs/features/Auth/data/repo/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() => null;

  // Future<String> _authenticate(
  //   Future<String> Function(AuthRepository authRepo) action,
  // ) async {
  //   state = const AsyncLoading();
  //   final result = await AsyncValue.guard(() async {
  //     final authRepo = ref.watch(authRepositoryProvider);
  //     await action(authRepo);
  //   });
  //   state = result;
  //   return result.value ?? (throw result.error);
  // }

  Future<void> login(LoginParams params) async {
    debugPrint('login controlelr');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authRepo = ref.watch(authRepositoryProvider);
      final token = await authRepo.login(params);
      ref.read(userDataProvider.notifier).setData(token, 0);
    });
  }

  Future<void> signup(RegisterParams params) async {
    debugPrint('signup controlelr');
    debugPrint("registeration signup controlelr : ${params.toString()}");

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authRepo = ref.watch(authRepositoryProvider);
      await authRepo.signup(params);
    });

    // await _authenticate(
    //   (authRepo) => authRepo.signup(params),
    // );
  }
}
