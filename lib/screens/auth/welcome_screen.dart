import 'package:budget_manager/screens/auth/login.dart';
import 'package:budget_manager/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';

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
              Align(
                alignment: Alignment.bottomCenter,
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
                              ).withOpacity(
                                0.5,
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
                            const LoginScreen(),
                            const SignUpScreen(),
                            // Login tab content
                          ],
                        ),
                      ),
                    ],
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
