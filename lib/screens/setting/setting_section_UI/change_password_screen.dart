import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen
    extends
        StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<
    ChangePasswordScreen
  >
  createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends
        State<
          ChangePasswordScreen
        > {
  final _formKey =
      GlobalKey<
        FormState
      >();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordRules(
    String value,
  ) {
    setState(
      () {
        containsUpperCase = value.contains(
          RegExp(
            r'[A-Z]',
          ),
        );
        containsLowerCase = value.contains(
          RegExp(
            r'[a-z]',
          ),
        );
        containsNumber = value.contains(
          RegExp(
            r'[0-9]',
          ),
        );
        containsSpecialChar = value.contains(
          RegExp(
            r'[!@#\$&*~`)%\-(_+=;:,.<>/?"\[\]{}\|^]',
          ),
        );
        contains8Length =
            value.length >=
            8;
      },
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
      ),
      labelText: label,
      filled: true,
      fillColor: const Color(
        0xFF0F1330,
      ),
      border: const OutlineInputBorder(),
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          obscure
              ? CupertinoIcons.eye_fill
              : CupertinoIcons.eye_slash_fill,
        ),
      ),
    );
  }

  Widget _ruleText(
    String text,
    bool isValid,
  ) {
    return Text(
      '⚈  $text',
      style: TextStyle(
        color: isValid
            ? Colors.green
            : Theme.of(
                context,
              ).colorScheme.onBackground,
        fontSize: 13,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          22,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              Container(
                height: 86,
                width: 86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(
                            0xFF8B5CF6,
                          ).withValues(
                            alpha: 0.35,
                          ),
                      blurRadius: 18,
                      offset: const Offset(
                        0,
                        8,
                      ),
                    ),
                  ],
                ),
                child: const Icon(
                  CupertinoIcons.lock_fill,
                  size: 38,
                  color: Colors.white,
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              const Text(
                'Update Your Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              const Text(
                'Choose a strong password to keep your account secure.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              TextFormField(
                controller: currentPasswordController,
                obscureText: obscureCurrentPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: _inputDecoration(
                  label: 'Current Password',
                  icon: CupertinoIcons.padlock_solid,
                  obscure: obscureCurrentPassword,
                  onToggle: () {
                    setState(
                      () {
                        obscureCurrentPassword = !obscureCurrentPassword;
                      },
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller: newPasswordController,
                obscureText: obscureNewPassword,
                keyboardType: TextInputType.visiblePassword,
                onChanged: _checkPasswordRules,
                decoration: _inputDecoration(
                  label: 'New Password',
                  icon: CupertinoIcons.lock_fill,
                  obscure: obscureNewPassword,
                  onToggle: () {
                    setState(
                      () {
                        obscureNewPassword = !obscureNewPassword;
                      },
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ruleText(
                        '1 uppercase',
                        containsUpperCase,
                      ),
                      _ruleText(
                        '1 lowercase',
                        containsLowerCase,
                      ),
                      _ruleText(
                        '1 number',
                        containsNumber,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ruleText(
                        '1 special character',
                        containsSpecialChar,
                      ),
                      _ruleText(
                        '8 minimum characters',
                        contains8Length,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: _inputDecoration(
                  label: 'Confirm New Password',
                  icon: CupertinoIcons.checkmark_shield_fill,
                  obscure: obscureConfirmPassword,
                  onToggle: () {
                    setState(
                      () {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      },
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 32,
              ),

              Container(
                width:
                    MediaQuery.of(
                      context,
                    ).size.width *
                    0.65,
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
                          const Color(
                            0xFF8B5CF6,
                          ).withValues(
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
                    // Business logic later
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      'Update Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
