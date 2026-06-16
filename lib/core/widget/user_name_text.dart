import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserNameText
    extends
        StatelessWidget {
  const UserNameText({
    super.key,
    this.style,
    this.fallback = 'User',
  });

  final TextStyle? style;
  final String fallback;

  String _cleanText(
    dynamic value,
  ) {
    if (value ==
        null) {
      return '';
    }

    return value.toString().trim();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final user = FirebaseAuth.instance.currentUser;

    if (user ==
        null) {
      return Text(
        fallback,
        style: style,
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

            final firestoreName = _cleanText(
              data?['name'],
            );

            final authName = _cleanText(
              user.displayName,
            );

            final displayName = firestoreName.isNotEmpty
                ? firestoreName
                : authName.isNotEmpty
                ? authName
                : fallback;

            return Text(
              displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style,
            );
          },
    );
  }
}
