import 'dart:math';

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
  bool LoginRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? errorMessage;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Form(
      key: _formKey,
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
                    } else if (value.length <
                        6) {
                      return 'Password must be at least 6 characters long';
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
          !LoginRequired
              ? SizedBox(
                  width:
                      MediaQuery.of(
                        context,
                      ).size.width *
                      0.5,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // context.read<LoginInBloc>().add(LoginRequired(
                        //   email: _emailController.text,
                        //   password: _passwordController.text,
                        // )
                        //);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF9A5DFF,
                      ),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8.0,
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
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
