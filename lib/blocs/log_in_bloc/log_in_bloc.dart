import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc
    extends
        Bloc<
          LogInEvent,
          LogInState
        > {
  final UserRepository _userRepository;

  LogInBloc({
    required UserRepository userRepository,
  }) : _userRepository = userRepository,
       super(
         LogInInitial(),
       ) {
    on<
      LogInRequired
    >(
      (
        event,
        emit,
      ) async {
        emit(
          LogInProcess(),
        );
        try {
          await _userRepository.logIn(
            event.email,
            event.password,
          );
          emit(
            LogInSuccess(),
          );
        } on FirebaseAuthException catch (
          e
        ) {
          emit(
            LogInFailure(
              error: e.code,
            ),
          );
        } catch (
          e
        ) {
          emit(
            const LogInFailure(
              error: "An unknown error occurred.",
            ),
          );
        }
      },
    );
    on<
      LogOutRequired
    >(
      ((
        event,
        emit,
      ) => _userRepository.logOut()),
    );
  }
}
