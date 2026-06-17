import 'package:budget_manager/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:budget_manager/core/utils/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen
    extends
        StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<
    SignUpScreen
  >
  createState() => _SignUpScreenState();
}

class _SignUpScreenState
    extends
        State<
          SignUpScreen
        > {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey =
      GlobalKey<
        FormState
      >();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocListener<
      SignUpBloc,
      SignUpState
    >(
      listener:
          (
            context,
            state,
          ) {
            if (state
                is SignUpSuccess) {
              setState(
                () {
                  signUpRequired = false;
                },
              );
              // Navigator.pop(context);
            } else if (state
                is SignUpProcess) {
              setState(
                () {
                  signUpRequired = true;
                },
              );
            } else if (state
                is SignUpFailure) {
              return;
            }
          },
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width:
                    MediaQuery.of(
                      context,
                    ).size.width *
                    0.9,
                child: TextFormField(
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.mail_solid,
                      color: AppColors.iconColor,
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: AppColors.textPrimary,
                    ),
                    filled: true,
                    fillColor: AppColors.filledColor,
                    border: const OutlineInputBorder(),
                    // errorText: errorMessage,
                  ),

                  validator:
                      (
                        val,
                      ) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (!RegExp(
                          r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$',
                        ).hasMatch(
                          val,
                        )) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width:
                    MediaQuery.of(
                      context,
                    ).size.width *
                    0.9,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.mail_solid,
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: AppColors.textPrimary,
                    ),
                    filled: true,
                    fillColor: AppColors.filledColor,
                    border: const OutlineInputBorder(),
                    //  errorText: errorMessage,
                    suffixIcon: IconButton(
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
                      icon: Icon(
                        iconPassword,
                        color: AppColors.iconColor,
                      ),
                    ),
                  ),
                  onChanged:
                      (
                        val,
                      ) {
                        if (val!.contains(
                          RegExp(
                            r'[A-Z]',
                          ),
                        )) {
                          setState(
                            () {
                              containsUpperCase = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              containsUpperCase = false;
                            },
                          );
                        }
                        if (val.contains(
                          RegExp(
                            r'[a-z]',
                          ),
                        )) {
                          setState(
                            () {
                              containsLowerCase = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              containsLowerCase = false;
                            },
                          );
                        }
                        if (val.contains(
                          RegExp(
                            r'[0-9]',
                          ),
                        )) {
                          setState(
                            () {
                              containsNumber = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              containsNumber = false;
                            },
                          );
                        }
                        if (val.contains(
                          RegExp(
                            r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])',
                          ),
                        )) {
                          setState(
                            () {
                              containsSpecialChar = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              containsSpecialChar = false;
                            },
                          );
                        }
                        if (val.length >=
                            8) {
                          setState(
                            () {
                              contains8Length = true;
                            },
                          );
                        } else {
                          setState(
                            () {
                              contains8Length = false;
                            },
                          );
                        }
                        return null;
                      },

                  validator:
                      (
                        val,
                      ) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$',
                        ).hasMatch(
                          val,
                        )) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚈  1 uppercase",
                        style: TextStyle(
                          color: containsUpperCase
                              ? Colors.green
                              : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        "⚈  1 lowercase",
                        style: TextStyle(
                          color: containsLowerCase
                              ? Colors.green
                              : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        "⚈  1 number",
                        style: TextStyle(
                          color: containsNumber
                              ? Colors.green
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚈  1 special character",
                        style: TextStyle(
                          color: containsSpecialChar
                              ? Colors.green
                              : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        "⚈  8 minimum character",
                        style: TextStyle(
                          color: contains8Length
                              ? Colors.green
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width:
                    MediaQuery.of(
                      context,
                    ).size.width *
                    0.9,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: AppColors.textPrimary,
                    ),
                    filled: true,
                    fillColor: AppColors.filledColor,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_fill,
                      color: AppColors.iconColor,
                    ),
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.name,

                  validator:
                      (
                        val,
                      ) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (val.length >
                            30) {
                          return 'Name too long';
                        }
                        return null;
                      },
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(
                      context,
                    ).size.height *
                    0.02,
              ),
              !signUpRequired
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
                              blurRadius: 16,
                              offset: const Offset(
                                0,
                                6,
                              ),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              MyUser myUser = MyUser.empty;
                              myUser = myUser.copyWith(
                                email: emailController.text,
                                name: nameController.text,
                              );
                              setState(
                                () {
                                  context
                                      .read<
                                        SignUpBloc
                                      >()
                                      .add(
                                        SignUpRequired(
                                          user: myUser,
                                          password: passwordController.text,
                                        ),
                                      );
                                },
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 3.0,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                60,
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 5,
                            ),
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
