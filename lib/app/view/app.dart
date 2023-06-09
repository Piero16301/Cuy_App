import 'package:cuy_app/app/app.dart';
import 'package:cuy_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_repository/local_repository.dart';
import 'package:user_repository/user_repository.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    required LocalRepository localRepository,
    required UserRepository userRepository,
    required GoRouter router,
    required String locale,
    super.key,
  })  : _localRepository = localRepository,
        _userRepository = userRepository,
        _router = router,
        _locale = locale;

  final LocalRepository _localRepository;
  final UserRepository _userRepository;
  final GoRouter _router;
  final String _locale;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _localRepository),
        RepositoryProvider.value(value: _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LanguageCubit(
              Locale(_locale.split('_')[0]),
              _localRepository,
            ),
          ),
        ],
        child: AppView(router: _router),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
    required GoRouter router,
  }) : _router = router;

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    final locale = context.select<LanguageCubit, Locale>(
      (cubit) => cubit.state.language,
    );

    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Colors.blueAccent,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16,
            fontFamily: 'Ubuntu-Regular',
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blueAccent,
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
    );
  }
}
