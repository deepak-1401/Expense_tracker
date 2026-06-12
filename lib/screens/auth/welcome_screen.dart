import 'package:budget_manager/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:budget_manager/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:budget_manager/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:budget_manager/screens/auth/login.dart';
import 'package:budget_manager/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:user_repository/user_repository.dart';

class WelcomeScreen
    extends
        StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<
    WelcomeScreen
  >
  createState() => _WelcomeScreenState();
}

class _WelcomeScreenState
    extends
        State<
          WelcomeScreen
        >
    with
        TickerProviderStateMixin {
  late TabController tabController;
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF070B2C,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(
            context,
          ).size.width,
          height: MediaQuery.of(
            context,
          ).size.height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 70.0,
                  horizontal: 55.0,
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to Budget Manager',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Manage your expenses efficiently',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 210,
                left: 0,
                right: 0,
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 120,
                  color: Color(
                    0xFF9A5DFF,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height:
                      MediaQuery.of(
                        context,
                      ).size.height *
                      0.55,
                  margin: const EdgeInsets.all(
                    25.0,
                  ),
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.06,
                    ),
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.15,
                      ),
                    ),
                  ),

                  child: SizedBox(
                    height:
                        MediaQuery.of(
                          context,
                        ).size.height /
                        1.8,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                          ),
                          child: TabBar(
                            controller: tabController,
                            unselectedLabelColor:
                                Color(
                                  0xFF9A5DFF,
                                ).withValues(
                                  alpha: 0.5,
                                ),
                            labelColor: Color(
                              0xFF9A5DFF,
                            ),
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.all(
                                  12.0,
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  12.0,
                                ),
                                child: Text(
                                  'Sign-Up',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              BlocProvider(
                                create:
                                    (
                                      context,
                                    ) => LogInBloc(
                                      userRepository: context
                                          .read<
                                            AuthenticationBloc
                                          >()
                                          .userRepository,
                                    ),
                                child: const LoginScreen(),
                              ),
                              BlocProvider(
                                create:
                                    (
                                      context,
                                    ) => SignUpBloc(
                                      UserRepository: context
                                          .read<
                                            AuthenticationBloc
                                          >()
                                          .userRepository,
                                    ),
                                child: const SignUpScreen(),
                              ),
                              // Login tab content
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
