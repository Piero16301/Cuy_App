import 'package:cuy_app/login/login.dart';
import 'package:go_router/go_router.dart';
import 'package:local_repository/local_repository.dart';

GoRouter goRouter(LocalRepository localRepository) {
  const unauthenticatedRoutes = <String>[
    '/login',
  ];

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      if (localRepository.getIsAuthenticated()) {
        return state.location == '/login' ? '/home' : null;
      } else {
        if (unauthenticatedRoutes.any(
          (route) {
            if (state.location != '/home') {
              return state.location.contains(route);
            }
            return false;
          },
        )) {
          return null;
        } else {
          return '/login';
        }
      }
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
