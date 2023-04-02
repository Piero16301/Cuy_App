import 'package:cuy_app/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_api/user_api.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserCubit, User>((cubit) => cubit.state.user!);

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.backToPlans) {
          context.go('/plans');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Detalles de usuario',
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Id: ${user.id}'),
                    const SizedBox(height: 10),
                    Text('Nombre: ${user.name}'),
                    const SizedBox(height: 10),
                    Text('Apellido paterno: ${user.lastNameFather}'),
                    const SizedBox(height: 10),
                    Text('Apellido materno: ${user.lastNameMother}'),
                    const SizedBox(height: 10),
                    Text('Apellido: ${user.lastName}'),
                    const SizedBox(height: 10),
                    const LogOutButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select<UserCubit, UserStatus>(
      (cubit) => cubit.state.status,
    );

    return ElevatedButton(
      onPressed: status.isLoading ? null : context.read<UserCubit>().logout,
      child: status.isLoading
          ? const SizedBox.square(
              dimension: 30,
              child: CircularProgressIndicator(),
            )
          : Text(
              'Cerrar sesión',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
    );
  }
}
