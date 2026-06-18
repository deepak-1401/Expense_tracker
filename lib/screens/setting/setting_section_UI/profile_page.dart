import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/screens/setting/widgets/avatar_picker_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile
    extends
        StatefulWidget {
  const Profile({
    super.key,
    this.selectedGender,
  });

  final String? selectedGender;

  @override
  State<
    Profile
  >
  createState() => _ProfileState();
}

class _ProfileState
    extends
        State<
          Profile
        > {
  String selectedAvatar = 'assets/avatar/avatar0.png';
  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (
            context,
          ) {
            return AvatarPickerBottomSheet(
              selectedAvatar: selectedAvatar,
              onAvatarSelected:
                  (
                    avatar,
                  ) {
                    setState(
                      () {
                        selectedAvatar = avatar;
                      },
                    );
                  },
            );
          },
    );
  }

  final _formKey =
      GlobalKey<
        FormState
      >();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? selectedGender;

  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
    loadProfileData();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    occupationController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<
    void
  >
  loadProfileData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user ==
        null) {
      setState(
        () {
          isLoading = false;
        },
      );
      return;
    }

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          )
          .get();

      final data = userDoc.data();

      if (data !=
          null) {
        nameController.text =
            data['name']?.toString() ??
            user.displayName ??
            '';

        ageController.text =
            data['age']?.toString() ??
            '';

        selectedGender = data['gender']?.toString();

        occupationController.text =
            data['occupation']?.toString() ??
            '';

        emailController.text =
            data['email']?.toString() ??
            user.email ??
            '';
        selectedAvatar =
            data['selectedAvatar']?.toString() ??
            'assets/avatar/avatar0.png';
      } else {
        nameController.text =
            user.displayName ??
            '';
        emailController.text =
            user.email ??
            '';
      }
    } catch (
      e
    ) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to load profile data',
          ),
        ),
      );
    }

    if (!mounted) return;

    setState(
      () {
        isLoading = false;
      },
    );
  }

  Future<
    void
  >
  saveProfileData() async {
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    setState(
      () {
        isSaving = true;
      },
    );
    // String selectedAvatar = 'assets/avatar/avatar0.png';

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user ==
          null) {
        throw Exception(
          "No user logged in",
        );
      }

      await FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          )
          .set(
            {
              'name': nameController.text.trim(),
              'age': ageController.text.trim(),
              'gender': selectedGender,
              'occupation': occupationController.text.trim(),
              'email': emailController.text.trim(),
              'selectedAvatar': selectedAvatar,
              'updatedAt': FieldValue.serverTimestamp(),
            },
            SetOptions(
              merge: true,
            ),
          );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: const Text(
            "Profile updated successfully",
          ),
          backgroundColor: extraColors.success,
        ),
      );
    } catch (
      e
    ) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to update profile",
          ),
          backgroundColor: extraColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(
          () {
            isSaving = false;
          },
        );
      }
    }
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: extraColors.fadeText,
      ),
      filled: true,
      fillColor: extraColors.filledColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
        borderSide: BorderSide(
          color: extraColors.fadeText.withValues(
            alpha: 0.5,
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
        borderSide: BorderSide(
          color: Theme.of(
            context,
          ).colorScheme.primary,
        ),
      ),
      prefixIcon: Icon(
        icon,
        color: extraColors.iconColor,
      ),
    );
  }

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
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),

                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                selectedAvatar,
                              ),
                            ),

                            GestureDetector(
                              onTap: _showAvatarPicker,
                              child: Container(
                                padding: const EdgeInsets.all(
                                  6,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: extraColors.iconColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        TextFormField(
                          controller: nameController,
                          style: TextStyle(
                            color: extraColors.textPrimary,
                          ),
                          decoration: inputDecoration(
                            label: 'Name',
                            icon: Icons.person,
                          ),
                          validator:
                              (
                                value,
                              ) {
                                if (value ==
                                        null ||
                                    value.trim().isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        TextFormField(
                          controller: ageController,
                          style: TextStyle(
                            color: extraColors.textPrimary,
                          ),
                          decoration: inputDecoration(
                            label: 'Age',
                            icon: Icons.calendar_today,
                          ),
                          keyboardType: TextInputType.number,
                          validator:
                              (
                                value,
                              ) {
                                if (value ==
                                        null ||
                                    value.trim().isEmpty) {
                                  return null;
                                }

                                final age = int.tryParse(
                                  value.trim(),
                                );

                                if (age ==
                                    null) {
                                  return 'Enter a valid age';
                                }

                                if (age <=
                                        0 ||
                                    age >
                                        120) {
                                  return 'Enter a valid age';
                                }

                                return null;
                              },
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        DropdownButtonFormField<
                          String
                        >(
                          key: ValueKey(
                            selectedGender,
                          ),
                          initialValue: selectedGender,
                          dropdownColor: extraColors.filledColor,
                          style: TextStyle(
                            color: extraColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            labelStyle: TextStyle(
                              color: extraColors.fadeText,
                            ),
                            filled: true,
                            fillColor: extraColors.filledColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              borderSide: BorderSide(
                                color: extraColors.fadeText.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              borderSide: BorderSide(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.wc_rounded,
                              color: Colors.red,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.male,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Male',
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.female,
                                    color: Colors.pink,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Female',
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Other',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.transgender,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Other',
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onChanged:
                              (
                                value,
                              ) {
                                setState(
                                  () {
                                    selectedGender = value;
                                  },
                                );
                              },
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        TextFormField(
                          controller: occupationController,
                          style: TextStyle(
                            color: extraColors.textPrimary,
                          ),
                          decoration: inputDecoration(
                            label: 'Occupation',
                            icon: Icons.work,
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        TextFormField(
                          controller: emailController,
                          readOnly: true,
                          style: TextStyle(
                            color: extraColors.textPrimary,
                          ),
                          decoration: inputDecoration(
                            label: 'Email',
                            icon: Icons.email,
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: Container(
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
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                disabledBackgroundColor: Colors.transparent,
                              ),
                              onPressed: isSaving
                                  ? null
                                  : saveProfileData,
                              child: isSaving
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: extraColors.textPrimary,
                                      ),
                                    )
                                  : Text(
                                      "Save Changes",
                                      style: TextStyle(
                                        color: extraColors.textPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
