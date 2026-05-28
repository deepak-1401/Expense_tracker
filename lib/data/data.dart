import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<
  Map<
    String,
    dynamic
  >
>
transactionData = [
  {
    'icon': FontAwesomeIcons.burger,
    'color': const Color(
      0xFFFF9A3D,
    ),
    'name': 'Food',

    'todayExpense': -500.0,
    'date': 'Today',
    'PaymentMethod': 'Credit Card',
  },

  {
    'icon': FontAwesomeIcons.bagShopping,
    'color': const Color(
      0xFF9A5DFF,
    ),
    'name': 'Shopping',

    'todayExpense': -1200.0,
    'date': 'Today',
    'PaymentMethod': 'Debit Card',
  },

  {
    'icon': FontAwesomeIcons.plane,
    'color': const Color(
      0xFF00E5FF,
    ),
    'name': 'Travel',

    'todayExpense': -2000.0,
    'date': 'Today',
    'PaymentMethod': 'Cash',
  },

  {
    'icon': FontAwesomeIcons.gamepad,
    'color': const Color(
      0xFFFF4B5C,
    ),
    'name': 'Entertainment',

    'todayExpense': -999.0,
    'date': 'Today',
    'PaymentMethod': 'Credit Card',
  },

  // {
  //   'icon': FontAwesomeIcons.houseMedical,
  //   'color': const Color(0xFF2B888),
  //   'name': 'Medical',

  //   'todayExpense': -1500.0,
  //   'date': 'Today',
  //   'PaymentMethod': 'Credit Card',
  // },

  // {
  //   'icon': FontAwesomeIcons.fileInvoiceDollar,
  //   'color': const Color(0xFF4DA8FF),
  //   'name': 'Bills',

  //   'todayExpense': -3500.0,
  //   'date': 'Today',
  //   'PaymentMethod': 'Debit Card',
  // },

  // {
  //   'icon': FontAwesomeIcons.book,
  //   'color': const Color(0xFF7B8CFF),
  //   'name': 'Education',

  //   'todayExpense': -2500.0,
  //   'date': 'Today',
  //   'PaymentMethod': 'Credit Card',
  // },

  // {
  //   'icon': FontAwesomeIcons.dumbbell,
  //   'color': const Color(0xFF00E5FF),
  //   'name': 'Gym',

  //   'todayExpense': -1800.0,
  //   'date': 'Today',
  //   'PaymentMethod': 'Debit Card',
  // },

  // {
  //   'icon': FontAwesomeIcons.chartLine,
  //   'color': const Color(0xFF00C896),
  //   'name': 'Investment',

  //   'todayExpense': -5000.0,
  //   'date': 'Today',
  //   'PaymentMethod': 'Credit Card',
  // },

  // {
  //   'icon': FontAwesomeIcons.wallet,
  //   'color': const Color(0xFF884CFF),
  //   'name': 'Salary',

  //   'todayExpense': 25000.0,
  //   'date': 'Today',
  //   'PaymentMethod': 'Credit Card',
  // },
];
