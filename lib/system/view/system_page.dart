import 'package:cuy_app/system/system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_repository/local_repository.dart';
import 'package:user_repository/user_repository.dart';

class SystemPage extends StatelessWidget {
  const SystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SystemCubit(
        context.read<LocalRepository>(),
        context.read<UserRepository>(),
      ),
      child: const SystemView(),
    );
  }
}
