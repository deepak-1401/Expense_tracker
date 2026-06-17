import 'package:budget_manager/theme/colours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsProfileHeader
    extends
        StatelessWidget {
  const SettingsProfileHeader({
    super.key,
  });

  String _cleanText(
    dynamic value,
  ) {
    if (value ==
        null)
      return '';
    return value.toString().trim();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final user = FirebaseAuth.instance.currentUser;

    if (user ==
        null) {
      return const Row(
        children: [
          CircleAvatar(
            radius: 28,
            child: Icon(
              color: AppColors.iconColor,
              Icons.person,
            ),
          ),
          SizedBox(
            width: 14,
          ),
          Text(
            'Guest User',
            style: TextStyle(
              color: AppColors.textPrimary,
            ),
          ),
        ],
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
            final firestoreEmail = _cleanText(
              data?['email'],
            );

            final authName = _cleanText(
              user.displayName,
            );
            final authEmail = _cleanText(
              user.email,
            );

            final displayName = firestoreName.isNotEmpty
                ? firestoreName
                : authName.isNotEmpty
                ? authName
                : 'User';

            final displayEmail = firestoreEmail.isNotEmpty
                ? firestoreEmail
                : authEmail.isNotEmpty
                ? authEmail
                : 'No email';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  displayEmail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fadeText,
                    fontSize: 13,
                  ),
                ),
              ],
            );
          },
    );
  }
}
