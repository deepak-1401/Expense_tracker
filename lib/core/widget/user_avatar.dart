import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAvatar
    extends
        StatelessWidget {
  const UserAvatar({
    super.key,
    this.radius = 28,
  });

  final double radius;

  @override
  Widget build(
    BuildContext context,
  ) {
    final user = FirebaseAuth.instance.currentUser;

    if (user ==
        null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(
          'assets/avatar/avatar1.png',
        ),
      );
    }

    return StreamBuilder<
      DocumentSnapshot<
        Map<
          String,
          dynamic
        >
      >
    >(
      stream: FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          )
          .snapshots(),
      builder:
          (
            context,
            snapshot,
          ) {
            final data = snapshot.data?.data();

            final avatarPath =
                data?['selectedAvatar']?.toString() ??
                'assets/avatar/avatar0.png';

            return CircleAvatar(
              radius: radius,
              backgroundImage: AssetImage(
                avatarPath,
              ),
            );
          },
    );
  }
}
