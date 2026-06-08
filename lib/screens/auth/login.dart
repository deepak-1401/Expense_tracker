import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  CupertinoIcons.clock_solid,
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
                        iconPassword = obscurePassword
                            ? CupertinoIcons.eye_solid
                            : CupertinoIcons.eye_fill;
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
                      return 'Password must contain at least one letter and one number';
                    }
                    return null;
                  },
            ),
          ),
        ],
      ),
    );
  }
}
