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
    this.isUserLoggedIn = false,
    this.androidInfo = const <String, dynamic>{},
    this.iosInfo = const <String, dynamic>{},
    this.packageInfo = const <String, dynamic>{},
  });

  final PlansStatus status;
  final List<List<Plan>> plans;
  final bool isUserLoggedIn;
  final Map<String, dynamic> androidInfo;
  final Map<String, dynamic> iosInfo;
  final Map<String, dynamic> packageInfo;

  PlansState copyWith({
    PlansStatus? status,
    List<List<Plan>>? plans,
    bool? isUserLoggedIn,
    Map<String, dynamic>? androidInfo,
    Map<String, dynamic>? iosInfo,
    Map<String, dynamic>? packageInfo,
  }) {
    return PlansState(
      status: status ?? this.status,
      plans: plans ?? this.plans,
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
      androidInfo: androidInfo ?? this.androidInfo,
      iosInfo: iosInfo ?? this.iosInfo,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }

  @override
  List<Object> get props => [
        status,
        plans,
        isUserLoggedIn,
        androidInfo,
        iosInfo,
        packageInfo,
      ];
}
