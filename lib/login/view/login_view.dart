import 'package:cuy_app/l10n/l10n.dart';
import 'package:cuy_app/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    context.read<LoginCubit>().initGlobalKey();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.go('/plans');
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.loginSnackBarError),
              duration: const Duration(seconds: 3),
            ),
          );
          context.read<LoginCubit>().restartStatus();
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.loginAppBarTitle,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
          ),
        ),
        body: Padding(
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
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: l10n.loginUserTextField,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: context.read<LoginCubit>().userChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return l10n.loginUserError;
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
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: l10n.loginPasswordTextField,
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
            return l10n.loginPasswordError;
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
    final l10n = context.l10n;

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
                  l10n.loginButton,
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
