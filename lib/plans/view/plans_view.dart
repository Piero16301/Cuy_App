import 'package:cuy_app/plans/plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_api/user_api.dart';

class PlansView extends StatelessWidget {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PlansCubit>().getPlans();

    return BlocBuilder<PlansCubit, PlansState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const PlansLoading();
        } else if (state.status.isFailure) {
          return const PlansFailure();
        } else {
          return const PlansSuccess();
        }
      },
    );
  }
}

class PlansLoading extends StatelessWidget {
  const PlansLoading({super.key});

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
                  'Cargando planes...',
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

class PlansFailure extends StatelessWidget {
  const PlansFailure({super.key});

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
                  'Error al cargar los planes',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: context.read<PlansCubit>().getPlans,
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

class PlansSuccess extends StatelessWidget {
  const PlansSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final plansList =
        context.select<PlansCubit, List<Plan>>((cubit) => cubit.state.plans[0]);
    final plansFree =
        context.select<PlansCubit, List<Plan>>((cubit) => cubit.state.plans[1]);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Lista de planes',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                if (plansList.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: plansList.length,
                    itemBuilder: (context, index) {
                      final plan = plansList[index];
                      return ListTile(
                        title: Text(plan.name),
                        subtitle: Text(plan.description),
                        trailing: Text(plan.price.toString()),
                      );
                    },
                  )
                else
                  const Text('No hay planes'),
                const SizedBox(height: 10),
                Text(
                  'Lista de planes gratis',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                if (plansFree.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: plansFree.length,
                    itemBuilder: (context, index) {
                      final plan = plansFree[index];
                      return ListTile(
                        title: Text(plan.name),
                        subtitle: Text(plan.description),
                        trailing: Text(plan.price.toString()),
                      );
                    },
                  )
                else
                  const Text('No hay planes gratis'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
