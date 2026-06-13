import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF070B2C,
      ),

      body: SafeArea(
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
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
                          onPressed: () {},
                          child: const Text(
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
    );
  }
}
