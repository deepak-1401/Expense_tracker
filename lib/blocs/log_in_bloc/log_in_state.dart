part of 'log_in_bloc.dart';

sealed class LogInState
    extends
        Equatable {
  const LogInState();

  @override
  List<
    Object
  >
  get props => [];
}

final class LogInInitial
    extends
        LogInState {}

final class LogInSuccess
    extends
        LogInState {}

final class LogInFailure
    extends
        LogInState {
  final String error;

  const LogInFailure({
    required this.error,
  });

  @override
  List<
    Object
  >
  get props => [
    error,
  ];
}

final class LogInProcess
    extends
        LogInState {}
