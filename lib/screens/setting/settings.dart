import 'package:budget_manager/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/about_app_screen.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/change_password_screen.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/currency_page.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/help_support_screen.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/logout_dialog.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/privacy_policy_screen.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/terms_conditions_screen.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/theme_page.dart';
import 'package:budget_manager/screens/setting/widgets/section_title.dart';
import 'package:budget_manager/screens/setting/widgets/settings_profile_header.dart';
import 'package:budget_manager/core/widget/user_avatar.dart';
import 'package:budget_manager/screens/setting/widgets/settings_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_manager/screens/setting/setting_section_UI/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class Setting
    extends
        StatefulWidget {
  const Setting({
    super.key,
  });

  @override
  State<
    Setting
  >
  createState() => _SettingState();
}

bool
notificationsEnabled = true;

class _SettingState
    extends
        State<
          Setting
        > {
  String selectedCurrency = "Indian Rupee (INR)";

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),

                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: extraColors.textPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              sectionTitle(
                "PROFILE",
                context,
              ),

              const SizedBox(
                height: 12,
              ),

              InkWell(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => const Profile(),
                    ),
                  );
                },
                child: Container(
                  width:
                      MediaQuery.of(
                        context,
                      ).size.width *
                      0.9,
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        extraColors.container,
                        extraColors.container.withValues(
                          alpha: 0.8,
                        ),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: extraColors.container,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: UserAvatar(
                          radius: 30,
                        ),
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      const Expanded(
                        child: SettingsProfileHeader(),
                      ),

                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: extraColors.iconColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              sectionTitle(
                "GENERAL",
                context,
              ),

              const SizedBox(
                height: 12,
              ),
              SettingsTile(
                title: "Theme",
                subtitle: "Dark",
                icon: CupertinoIcons.sun_max_fill,
                iconColor: const Color(
                  0xFF9B4EFF,
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder:
                        (
                          context,
                        ) {
                          return const ThemePage();
                        },
                  );
                },
              ),

              const SizedBox(
                height: 12,
              ),

              SettingsTile(
                title: "Currency",
                subtitle: selectedCurrency,
                icon: Icons.currency_rupee_rounded,
                iconColor: const Color(
                  0xFF22C55E,
                ),
                onTap: () async {
                  final result = await showDialog(
                    context: context,
                    builder:
                        (
                          context,
                        ) {
                          return const CurrencyPage();
                        },
                  );

                  if (result !=
                      null) {
                    setState(
                      () {
                        selectedCurrency = "${result['name']} (${result['code']})";
                      },
                    );
                  }
                },
              ),

              const SizedBox(
                height: 12,
              ),
              SettingsTile(
                title: "Notification",
                subtitle: "Manage your notification",
                icon: Icons.notifications_none_rounded,

                iconColor: Color(
                  0xFFFF9A3D,
                ),
                onTap: () {},
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged:
                      (
                        value,
                      ) {
                        setState(
                          () {
                            notificationsEnabled = value;
                          },
                        );
                      },
                ),
              ),

              sectionTitle(
                "ACCOUNT",
                context,
              ),

              const SizedBox(
                height: 12,
              ),
              SettingsTile(
                title: "Change Password",
                subtitle: "Update your password",
                icon: Icons.lock_outline,
                iconColor: Color(
                  0xFF2563EB,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => BlocProvider(
                            create:
                                (
                                  context,
                                ) => ChangePasswordBloc(
                                  userRepository: context
                                      .read<
                                        UserRepository
                                      >(),
                                ),
                            child: const ChangePasswordScreen(),
                          ),
                    ),
                  );
                },
              ),

              sectionTitle(
                "ABOUT",
                context,
              ),

              const SizedBox(
                height: 12,
              ),
              SettingsTile(
                title: "Terms & Conditions",
                subtitle: "Review our terms and conditions",
                icon: CupertinoIcons.doc_fill,
                iconColor: Color(
                  0xFF7C3AED,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => const TermsConditionsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 12,
              ),

              SettingsTile(
                title: "Help & Support",
                subtitle: "Get help and support",
                icon: CupertinoIcons.question_circle,
                iconColor: Color(
                  0xFF10B981,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => const HelpSupportScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 12,
              ),

              SettingsTile(
                title: "Privacy Policy",
                subtitle: "View our privacy policy",
                icon: Icons.privacy_tip_outlined,

                iconColor: Color(
                  0xFF2563EB,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 12,
              ),

              SettingsTile(
                title: "About App",
                subtitle: "Learn more about the app",
                icon: Icons.info_outline,
                iconColor: Color(
                  0xFFF59E0B,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (
                            context,
                          ) => const AboutAppScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 35,
              ),
              SettingsTile(
                title: "Logout",
                subtitle: "Sign out of your account",
                icon: CupertinoIcons.power,
                iconColor: Theme.of(
                  context,
                ).colorScheme.primary,
                onTap: () {
                  showLogoutDialog(
                    context,
                  );
                },
              ),
              sectionTitle(
                "App Info",
                context,
              ),

              const SizedBox(
                height: 10,
              ),

              Column(
                children: [
                  Text(
                    'Expense Tracker',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline,
                      fontSize: 12,
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
