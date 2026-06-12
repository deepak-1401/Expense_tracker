import 'dart:developer';

import 'package:user_repository/src/user_repo.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepo
    implements
        UserRepository {
  final FirebaseAuth _firebaseAuth;

  final userCollection = FirebaseFirestore.instance.collection(
    'users',
  );

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth =
           firebaseAuth ??
           FirebaseAuth.instance;

  @override
  Stream<
    User?
  >
  get user {
    return _firebaseAuth.authStateChanges().map(
      (
        firebaseUser,
      ) {
        print(
          'firebaseUser = $firebaseUser',
        );
        return firebaseUser;
      },
    );
  }

  @override
  Future<
    void
  >
  logIn(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (
      e
    ) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<
    MyUser
  >
  signUp(
    MyUser myUser,
    String password,
  ) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      myUser = myUser.copyWith(
        userId: user.user!.uid,
      );

      return myUser;
    } catch (
      e
    ) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<
    void
  >
  setUserData(
    MyUser myUser,
  ) async {
    try {
      await userCollection
          .doc(
            myUser.userId,
          )
          .set(
            myUser.toEntity().toDocument(),
          );
    } catch (
      e
    ) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<
    void
  >
  logOut() async {
    try {
      await GoogleSignIn.instance.signOut();

      await _firebaseAuth.signOut();
    } catch (
      e
    ) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<
    UserCredential
  >
  signInWithGoogle() async {
    print(
      "GOOGLE FUNCTION STARTED",
    );

    await GoogleSignIn.instance.initialize();

    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

    print(
      "GOOGLE AUTHENTICATED: ${googleUser.email}",
    );

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    print(
      "FIREBASE LOGIN SUCCESS",
    );

    final user = userCredential.user;

    print(
      "USER UID: ${user?.uid}",
    );

    if (user !=
        null) {
      final userDoc = FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          );

      final docSnapshot = await userDoc.get();

      print(
        "DOC EXISTS: ${docSnapshot.exists}",
      );

      if (!docSnapshot.exists) {
        await userDoc.set(
          {
            'userId': user.uid,
            'email': user.email,
            'name':
                user.displayName ??
                '',
            'photoUrl':
                user.photoURL ??
                '',
            'createdAt': FieldValue.serverTimestamp(),
          },
        );

        print(
          "USER DOC CREATED",
        );
      }
    }

    return userCredential;
  }
}
