import 'package:budget_manager/theme/app_theme.dart';
import 'package:budget_manager/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:budget_manager/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_manager/screens/auth/welcome_screen.dart';
import 'package:budget_manager/screens/home/views/home_screen.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView
    extends
        StatelessWidget {
  const MyAppView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Budget Manager",
      theme: AppTheme.darkTheme,

      home:
          BlocBuilder<
            AuthenticationBloc,
            AuthenticationState
          >(
            builder:
                (
                  context,
                  state,
                ) {
                  if (state.status ==
                      AuthenticationStatus.authenticated) {
                    return BlocProvider(
                      create:
                          (
                            context,
                          ) =>
                              GetExpensesBloc(
                                FirebaseExpenseRepo(),
                              )..add(
                                GetExpenses(),
                              ),
                      child: const HomeScreen(),
                    );
                  } else {
                    return const WelcomeScreen();
                  }
                },
          ),
    );
  }
}
