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
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Icon(
                  Icons.lock_reset_rounded,
                  size: 120,
                  color: Color(
                    0xFF9A5DFF,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  24.0,
                ),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
