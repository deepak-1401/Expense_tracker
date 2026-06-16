import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends
        Bloc<
          ChangePasswordEvent,
          ChangePasswordState
        > {
  final UserRepository _userRepository;

  ChangePasswordBloc({
    required UserRepository userRepository,
  }) : _userRepository = userRepository,
       super(
         ChangePasswordInitial(),
       ) {
    on<
      ChangePasswordRequired
    >(
      (
        event,
        emit,
      ) async {
        emit(
          ChangePasswordProcess(),
        );

        try {
          await _userRepository.changePassword(
            currentPassword: event.currentPassword,
            newPassword: event.newPassword,
          );

          emit(
            ChangePasswordSuccess(),
          );
        } on FirebaseAuthException catch (
          e
        ) {
          emit(
            ChangePasswordFailure(
              error: e.code,
            ),
          );
        } catch (
          e
        ) {
          emit(
            const ChangePasswordFailure(
              error: 'An unknown error occurred.',
            ),
          );
        }
      },
    );
  }
}
