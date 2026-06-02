import 'package:budget_manager/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
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
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(
          0xFF070B2C,
        ),

        colorScheme: ColorScheme.dark(
          surface: Color(
            0xFF070B2C,
          ),
          //onSurface: Color(0xFF070B2C),
          primary: Color(
            0xFF6A3EF2,
          ),
          secondary: Color(
            0xFF9D47FF,
          ),
          tertiary: Color(
            0xFFFF5DAB,
          ),
        ),
      ),

      home: BlocProvider(
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
      ),
    );
  }
}
