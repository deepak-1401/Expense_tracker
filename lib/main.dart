import 'package:budget_manager/app.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'simple_bloc_observer.dart';
import 'package:budget_manager/screens/add_expense/blocs/create_categoryblocs/create_category_bloc.dart';
import 'package:user_repository/user_repository.dart';

void
main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final expenseRepository = FirebaseExpenseRepo();

  Bloc.observer = SimpleBlocObserver();

  runApp(
    BlocProvider(
      create:
          (
            context,
          ) => CreateCategoryBloc(
            expenseRepository,
          ),

      child: MyApp(
        FirebaseUserRepo(),
      ),
    ),
  );
}
