part of 'system_cubit.dart';

enum SystemStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == SystemStatus.initial;
  bool get isLoading => this == SystemStatus.loading;
  bool get isSuccess => this == SystemStatus.success;
  bool get isFailure => this == SystemStatus.failure;
}

class SystemState extends Equatable {
  const SystemState({
    this.status = SystemStatus.initial,
  });

  final SystemStatus status;

  SystemState copyWith({
    SystemStatus? status,
  }) {
    return SystemState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
