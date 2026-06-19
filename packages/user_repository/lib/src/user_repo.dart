import 'package:user_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Stream<
    User?
  >
  get user;

  Future<
    MyUser
  >
  signUp(
    MyUser myUser,
    String password,
  );

  Future<
    void
  >
  setUserData(
    MyUser myUser,
  );

  Future<
    void
  >
  logIn(
    String email,
    String password,
  );

  Future<
    void
  >
  logOut();

  Future<
    void
  >
  signInWithGoogle();

  Future<
    void
  >
  changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<
    Map<
      String,
      dynamic
    >?
  >
  getUserProfile();

  Future<
    void
  >
  updateUserProfile({
    required String name,
    required String age,
    required String gender,
    required String occupation,
    required String selectedAvatar,
  });

  Future<
    void
  >
  resetPassword(
    String email,
  );
}
