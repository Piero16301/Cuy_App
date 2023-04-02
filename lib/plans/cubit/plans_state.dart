part of 'plans_cubit.dart';

enum PlansStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == PlansStatus.initial;
  bool get isLoading => this == PlansStatus.loading;
  bool get isSuccess => this == PlansStatus.success;
  bool get isFailure => this == PlansStatus.failure;
}

class PlansState extends Equatable {
  const PlansState({
    this.status = PlansStatus.initial,
    this.plans = const <List<Plan>>[],
  });

  final PlansStatus status;
  final List<List<Plan>> plans;

  PlansState copyWith({
    PlansStatus? status,
    List<List<Plan>>? plans,
  }) {
    return PlansState(
      status: status ?? this.status,
      plans: plans ?? this.plans,
    );
  }

  @override
  List<Object> get props => [
        status,
        plans,
      ];
}
