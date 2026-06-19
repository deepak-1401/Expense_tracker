import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen
    extends
        StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  State<
    ForgetPasswordScreen
  >
  createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState
    extends
        State<
          ForgetPasswordScreen
        > {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  bool isEmailSent = false;
  Future<
    void
  >
  resetPassword() async {
    // 1. Get the email
    final String email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your email',
          ),
        ),
      );
      return;
    }

    if (!email.contains(
          '@',
        ) ||
        !email.contains(
          '.',
        )) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a valid email address',
          ),
        ),
      );
      return;
    }

    // 3. Start loading
    setState(
      () {
        isLoading = true;
      },
    );

    try {
      await context
          .read<
            UserRepository
          >()
          .resetPassword(
            emailController.text.trim(),
          );

      setState(
        () {
          isEmailSent = true;
        },
      );

      emailController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset link sent! Check your email.',
          ),
        ),
      );
    } on FirebaseAuthException catch (
      e
    ) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            e.message ??
                'Something went wrong',
          ),
        ),
      );
    } finally {
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF070B2C,
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(
              context,
            ).size.width,
            height: MediaQuery.of(
              context,
            ).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    24.0,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Icon(
                          Icons.lock_reset_rounded,
                          size: 120,
                          color: Color(
                            0xFF9A5DFF,
                          ),
                        ),
                        const Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'No worries! Just enter your email and we will send you a reset your password.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: isEmailSent
                      ? Container(
                          width: double.infinity,

                          height:
                              MediaQuery.of(
                                context,
                              ).size.height /
                              2.5,

                          margin: const EdgeInsets.all(
                            25.0,
                          ),

                          padding: const EdgeInsets.all(
                            22,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: 0.06,
                            ),
                            borderRadius: BorderRadius.circular(
                              24,
                            ),
                            border: Border.all(
                              color: Colors.greenAccent.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                color: Colors.greenAccent,
                                size: 70,
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Email Sent!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'We have sent a password reset link to your email.\n'
                                'Please check your inbox and spam folder.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                              Divider(
                                color: Colors.white24,
                              ),

                              SizedBox(
                                height: 16,
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.tips_and_updates_outlined,
                                    color: Colors.amberAccent,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Didn't receive the email?\n"
                                      "• Check your Spam/Junk folder.\n"
                                      "• Make sure you entered the correct email address.",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 13,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height:
                              MediaQuery.of(
                                context,
                              ).size.height *
                              0.2,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              TextFormField(
                                controller: emailController,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    CupertinoIcons.mail_solid,
                                  ),
                                  labelText: 'Enter your email',
                                  labelStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
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
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    60,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    isLoading
                                        ? null
                                        : resetPassword();
                                  },
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          'Send Reset Link',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.06,
                    ),
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.12,
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color(
                          0xFF9A5DFF,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          'We will send you an email with instructions to reset your password.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(
                  height: 40,

                  indent: 50,
                  endIndent: 50,
                  color: Colors.white.withValues(
                    alpha: 0.1,
                  ),
                ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remember your password? ',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Color(
                            0xFF9A5DFF,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
