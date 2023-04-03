import 'dart:async';

import 'package:cuy_app/plans/plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_api/user_api.dart';

class PlansView extends StatefulWidget {
  const PlansView({super.key});

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> with WidgetsBindingObserver {
  late StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    context.read<PlansCubit>().getPlans();

    _subscription = Stream<void>.periodic(
      const Duration(milliseconds: 100),
    ).listen(
      (_) => context.read<PlansCubit>().updateIsUserLoggedIn(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _subscription.resume();
    } else {
      if (!_subscription.isPaused) {
        _subscription.pause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
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
    final isUserLoggedIn = context.select<PlansCubit, bool>(
      (cubit) => cubit.state.isUserLoggedIn,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Planes',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                isUserLoggedIn ? context.push('/user') : context.push('/login'),
            child: Text(
              isUserLoggedIn ? 'Mi cuenta' : 'Iniciar sesión',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lista de planes',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
              if (plansList.isNotEmpty)
                Column(
                  children:
                      plansList.map((plan) => PlanItem(plan: plan)).toList(),
                )
              else
                const Center(child: Text('No hay planes')),
              const SizedBox(height: 20),
              Text(
                'Lista de planes gratis',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (plansFree.isNotEmpty)
                Column(
                  children:
                      plansFree.map((plan) => PlanItem(plan: plan)).toList(),
                )
              else
                const Text('No hay planes gratis'),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanItem extends StatelessWidget {
  const PlanItem({
    required this.plan,
    super.key,
  });

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'ID Paquete: ${plan.bundleId}',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: Theme.of(context).textTheme.bodyMedium,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${plan.name}'),
              Text('Descripción: ${plan.description}'),
              Text('Cantidad: ${plan.quantity}'),
              Text('Cantidad real: ${plan.quantityReal}'),
              Text('Precio: ${plan.price}'),
              Text('Duración: ${plan.duration}'),
              Text('Es seleccionado: ${plan.isSelected}'),
              Text('Es ilimitado: ${plan.isUnlimited}'),
              Text('ID de precio plan: ${plan.pricePlanID}'),
              Text('Es popular: ${plan.isPopular}'),
              Text('Es recomendado: ${plan.isRecommended}'),
              Text('Recomprar: ${plan.repurchase}'),
              Text('Es rollover: ${plan.isRollover}'),
              Text('Nombre 2: ${plan.name2}'),
              Text('Nombre 3: ${plan.name3}'),
              Text('Tiene aplicaciones gratis: ${plan.hasFreeApps}'),
              Text('Tiene Facebook full: ${plan.hasFacebookFull}'),
              Text('Tiene Instagram full: ${plan.hasInstagramFull}'),
              Text('Tiene foto Facebook: ${plan.hasFacebookPhoto}'),
              Text('Tiene foto Instagram: ${plan.hasInstagramPhoto}'),
              Text('Descripción Facebook: ${plan.facebookFullDesc}'),
              Text('Nombre grupo: ${plan.groupName}'),
              Text('Nombre byte: ${plan.nameByte}'),
              Text('Nombre segundo: ${plan.nameSecond}'),
              Text('Nombre SMS: ${plan.nameSms}'),
              Text('Byte ilimitado: ${plan.isUnlimitedByte}'),
              Text('Segundo ilimitado: ${plan.isUnlimitedSecond}'),
              Text('SMS ilimitado: ${plan.isUnlimitedSms}'),
              Text('Cantidad byte: ${plan.quantityByte}'),
              Text('Cantidad segundo: ${plan.quantitySecond}'),
              Text('Cantidad SMS: ${plan.quantitySms}'),
              Text('IDs paquetes: ${plan.bundleIds}'),
              Text('Velocidad media: ${plan.mediumSpeed}'),
              Text(
                'Descripción velocidad media: ${plan.mediumSpeedDescription}',
              ),
              Text('Tipo de paquete: ${plan.bundleType}'),
              Text('Brand blanco: ${plan.whiteBrand}'),
              Text('Aplicaciones gratis: ${plan.freeApps}'),
              Text('Migraciones: ${plan.migrations}'),
            ],
          ),
          scrollable: true,
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cerrar',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    plan.description,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '\$ ${plan.price}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
