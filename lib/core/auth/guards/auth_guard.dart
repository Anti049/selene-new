import 'package:auto_route/auto_route.dart';
import 'package:selene/core/auth/repositories/auth_repository.dart';
import 'package:selene/routing/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthRepository authRepository;

  AuthGuard(this.authRepository);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = authRepository.currentUser != null;

    if (isAuthenticated) {
      resolver.next(true);
    } else {
      router.push(AuthRoute());
    }
  }
}
