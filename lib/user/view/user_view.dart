import 'package:cuy_app/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_api/user_api.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserCubit, User>((cubit) => cubit.state.user!);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de usuario',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
