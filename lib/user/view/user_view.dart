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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  UserAttributeItem(
                    title: 'Nombre',
                    content: user.name,
                  ),
                  UserAttributeItem(
                    title: 'Apellido paterno',
                    content: user.lastNameFather,
                  ),
                  UserAttributeItem(
                    title: 'Apellido materno',
                    content: user.lastNameMother,
                  ),
                  UserAttributeItem(
                    title: 'Apellido',
                    content: user.lastName,
                  ),
                  UserAttributeItem(
                    title: 'Nombre completo',
                    content: user.fullName,
                  ),
                  UserAttributeItem(
                    title: 'Email',
                    content: user.email,
                  ),
                  UserAttributeItem(
                    title: 'DNI',
                    content: user.dni,
                  ),
                  UserAttributeItem(
                    title: 'Tipo de identificación de usuario',
                    content: user.userIdentificationType.toString(),
                  ),
                  UserAttributeItem(
                    title: 'Nombre corporativo',
                    content: user.businessName,
                  ),
                  UserAttributeItem(
                    title: 'Dirección',
                    content: user.address,
                  ),
                  UserAttributeItem(
                    title: 'Cumpleaños',
                    content: user.birthday,
                  ),
                  UserAttributeItem(
                    title: 'Código referido',
                    content: user.referralCode,
                  ),
                  UserAttributeItem(
                    title: 'URL referida',
                    content: user.referralUrl,
                  ),
                  UserAttributeItem(
                    title: 'ID zoho',
                    content: user.zohoId,
                  ),
                  UserAttributeItem(
                    title: 'Foto',
                    content: user.photo,
                  ),
                  UserAttributeItem(
                    title: 'Tiene foto',
                    content: user.hasPhoto.toString(),
                  ),
                  UserAttributeItem(
                    title: 'Logeado por teléfono',
                    content: user.loggedWithPhone,
                  ),
                  UserAttributeItem(
                    title: 'Región',
                    content: user.region,
                  ),
                  UserAttributeItem(
                    title: 'Es turista',
                    content: user.isTourist.toString(),
                  ),
                  UserAttributeItem(
                    title: 'Es representante legal',
                    content: user.isLegalRepresentantOfCompany.toString(),
                  ),
                  UserAttributeItem(
                    title: 'Compañía',
                    content: user.company.toString(),
                  ),
                  const SizedBox(height: 20),
                  const LogOutButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserAttributeItem extends StatelessWidget {
  const UserAttributeItem({
    required this.title,
    required this.content,
    super.key,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
          Text(
            ':',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              content.isEmpty ? 'No asignado' : content,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
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
