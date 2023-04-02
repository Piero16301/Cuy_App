import 'package:cuy_app/system/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SystemView extends StatelessWidget {
  const SystemView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SystemCubit>().getSystemOAuthToken();

    return BlocConsumer<SystemCubit, SystemState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.go('/plans');
        }
      },
      builder: (context, state) {
        if (state.status.isLoading) {
          return const SystemOAuthTokenLoading();
        } else if (state.status.isFailure) {
          return const SystemOAuthTokenFailure();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class SystemOAuthTokenLoading extends StatelessWidget {
  const SystemOAuthTokenLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Autenticando con el sistema...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SystemOAuthTokenFailure extends StatelessWidget {
  const SystemOAuthTokenFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Error al autenticar con el sistema',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: context.read<SystemCubit>().getSystemOAuthToken,
                  child: Text(
                    'Reintentar',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
