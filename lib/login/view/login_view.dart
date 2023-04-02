import 'package:cuy_app/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LoginCubit>().initGlobalKey();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.go('/home');
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario o contraseña incorrectos'),
              duration: Duration(seconds: 3),
            ),
          );
          context.read<LoginCubit>().restartStatus();
        }
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: state.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ImageLogoLogin(),
                      SizedBox(height: 30),
                      UserFormLogin(),
                      SizedBox(height: 20),
                      PasswordFormLogin(),
                      SizedBox(height: 30),
                      ButtonLogin(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageLogoLogin extends StatelessWidget {
  const ImageLogoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 60,
        child: FlutterLogo(
          style: FlutterLogoStyle.horizontal,
          size: double.infinity,
        ),
      ),
    );
  }
}

class UserFormLogin extends StatelessWidget {
  const UserFormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Usuario',
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: context.read<LoginCubit>().userChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su usuario';
          }
          return null;
        },
      ),
    );
  }
}

class PasswordFormLogin extends StatelessWidget {
  const PasswordFormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = context
        .select<LoginCubit, bool>((cubit) => cubit.state.isPasswordVisible);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Contraseña',
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: context.read<LoginCubit>().togglePasswordVisibility,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        obscureText: !isPasswordVisible,
        onChanged: context.read<LoginCubit>().passwordChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su contraseña';
          }
          return null;
        },
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final status =
        context.select<LoginCubit, LoginStatus>((cubit) => cubit.state.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: status.isLoading
              ? null
              : () {
                  context.read<LoginCubit>().login();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
          child: status.isLoading
              ? const SizedBox.square(
                  dimension: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Iniciar sesión',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
