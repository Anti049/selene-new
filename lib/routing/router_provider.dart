import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/auth/providers/auth_providers.dart';
import 'package:selene/routing/router.dart';

part 'router_provider.g.dart';

@riverpod
AppRouter appRouter(Ref ref) {
  return AppRouter(authRepository: ref.watch(authRepositoryProvider));
}
