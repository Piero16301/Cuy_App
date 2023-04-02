import 'package:cuy_app/login/login.dart';
import 'package:cuy_app/plans/plans.dart';
import 'package:cuy_app/system/system.dart';
import 'package:go_router/go_router.dart';
import 'package:local_repository/local_repository.dart';

GoRouter goRouter(LocalRepository localRepository) {
  return GoRouter(
    initialLocation: '/system',
    routes: [
      GoRoute(
        path: '/system',
        builder: (context, state) => const SystemPage(),
      ),
      GoRoute(
        path: '/plans',
        builder: (context, state) => const PlansPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
