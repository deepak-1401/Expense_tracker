//import 'dart:math';
import 'package:budget_manager/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen
    extends
        StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<
    LoginScreen
  >
  createState() => _LoginScreenState();
}

class _LoginScreenState
    extends
        State<
          LoginScreen
        > {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey =
      GlobalKey<
        FormState
      >();
  bool loginRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? errorMessage;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _emailController,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.mail_solid,
                  ),
                  labelText: 'Email',
                  filled: true,
                  fillColor: const Color(
                    0xFF0F1330,
                  ),
                  border: const OutlineInputBorder(),
                  errorText: errorMessage,
                ),
                validator:
                    (
                      value,
                    ) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                        r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(
                        value,
                      )) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _passwordController,
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.padlock_solid,
                  ),
                  labelText: 'Password',
                  filled: true,
                  fillColor: const Color(
                    0xFF0F1330,
                  ),
                  border: const OutlineInputBorder(),
                  errorText: errorMessage,
                  suffixIcon: IconButton(
                    icon: Icon(
                      iconPassword,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          obscurePassword = !obscurePassword;
                          if (obscurePassword) {
                            iconPassword = CupertinoIcons.eye_fill;
                          } else {
                            iconPassword = CupertinoIcons.eye_slash_fill;
                          }
                        },
                      );
                    },
                  ),
                ),
                validator:
                    (
                      value,
                    ) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (!RegExp(
                        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
                      ).hasMatch(
                        value,
                      )) {
                        return 'Password must be a combination of letters and numbers';
                      }
                      return null;
                    },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            !loginRequired
                ? SizedBox(
                    width:
                        MediaQuery.of(
                          context,
                        ).size.width *
                        0.5,
                    child: Container(
                      width:
                          MediaQuery.of(
                            context,
                          ).size.width *
                          0.55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(
                              context,
                            ).colorScheme.tertiary,
                            Theme.of(
                              context,
                            ).colorScheme.secondary,
                            Theme.of(
                              context,
                            ).colorScheme.primary,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          60,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color(
                                  0xFF8B5CF6,
                                ).withValues(
                                  alpha: 0.35,
                                ),
                            blurRadius: 15,
                            offset: Offset(
                              0,
                              6,
                            ),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          print(
                            "LOGIN BUTTON CLICKED",
                          );

                          if (_formKey.currentState!.validate()) {
                            context
                                .read<
                                  LogInBloc
                                >()
                                .add(
                                  LogInRequired(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              60.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
            Divider(
              height: 40,
              thickness: 1,
              indent: 50,
              endIndent: 50,
            ),

            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  context
                      .read<
                        LogInBloc
                      >()
                      .add(
                        LogInWithGoogleRequired(),
                      );
                },
                icon: Image.asset(
                  'assets/google_logo.png',
                  height: 50,
                ),
                label: const Text(
                  "Continue with Google",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
