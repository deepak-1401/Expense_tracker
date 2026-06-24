//import 'dart:math';
import 'package:budget_manager/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/screens/auth/forget_password.dart';
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
  //String? errorMessage;
  String? emailError;
  String? passwordError;

  @override
  Widget build(
    BuildContext context,
  ) {
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    return BlocListener<
      LogInBloc,
      LogInState
    >(
      listener:
          (
            context,
            state,
          ) {
            if (state
                is LogInFailure) {
              setState(
                () {
                  emailError = null;
                  passwordError = null;
                  loginRequired = false;
                },
              );

              if (state.error ==
                  'user-not-found') {
                setState(
                  () {
                    emailError = 'Enter correct email';
                  },
                );
              } else if (state.error ==
                      'wrong-password' ||
                  state.error ==
                      'invalid-credential') {
                setState(
                  () {
                    passwordError = 'Enter correct password';
                  },
                );
              }
            }
          },

      child: Form(
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
                    prefixIcon: Icon(
                      CupertinoIcons.mail_solid,
                      color: extraColors.iconColor,
                    ),
                    labelText: 'Email',
                    filled: true,
                    fillColor: extraColors.filledColor,
                    border: const OutlineInputBorder(),
                    errorText: emailError,
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
                    prefixIcon: Icon(
                      CupertinoIcons.padlock_solid,
                      color: extraColors.iconColor,
                    ),
                    labelText: 'Password',
                    filled: true,
                    fillColor: extraColors.filledColor,

                    border: const OutlineInputBorder(),
                    errorText: passwordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        iconPassword,
                        color: extraColors.iconColor,
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
                        } else {
                          return null;
                        }
                        // return null;
                      },
                ),
              ),
              SizedBox(
                height: 3,
              ),
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (
                                  context,
                                ) => const ForgetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 3,
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
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(
                                    alpha: 0.35,
                                  ),
                              blurRadius: 15,
                              offset: const Offset(
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

                            setState(
                              () {
                                emailError = null;
                                passwordError = null;
                                loginRequired = true;
                              },
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
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: extraColors.textPrimary,
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
                    'assets/logos/google_logo.png',
                    height: 50,
                  ),
                  label: Text(
                    "Continue with Google",
                    style: TextStyle(
                      color: extraColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
