import 'package:cuy_app/plans/plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_repository/local_repository.dart';
import 'package:user_repository/user_repository.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlansCubit(
        context.read<UserRepository>(),
        context.read<LocalRepository>(),
      ),
      child: const PlansView(),
    );
  }
}
