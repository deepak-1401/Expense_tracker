import 'package:flutter/material.dart';

Widget
sectionTitle(
  String title,
) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 24,
      bottom: 10,
      top: 18,
    ),
    child: Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,

            color: Colors.grey.withValues(
              alpha: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
}
