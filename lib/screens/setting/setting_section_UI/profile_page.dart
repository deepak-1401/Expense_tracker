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
            data['avatar']?.toString() ??
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
    FocusScope.of(
      context,
    ).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user ==
        null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'User not found. Please login again.',
          ),
        ),
      );
      return;
    }

    setState(
      () {
        isSaving = true;
      },
    );

    try {
      final String name = nameController.text.trim();
      final String ageText = ageController.text.trim();
      final String occupation = occupationController.text.trim();

      await FirebaseFirestore.instance
          .collection(
            'users',
          )
          .doc(
            user.uid,
          )
          .set(
            {
              'userId': user.uid,
              'name': name,
              'age': ageText.isEmpty
                  ? null
                  : int.parse(
                      ageText,
                    ),
              'gender': selectedGender,
              'occupation': occupation,
              'email': user.email,
              'avatar': selectedAvatar,

              'updatedAt': FieldValue.serverTimestamp(),
            },
            SetOptions(
              merge: true,
            ),
          );

      await user.updateDisplayName(
        name,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Profile updated successfully',
          ),
        ),
      );

      Navigator.pop(
        context,
        true,
      );
    } on FirebaseException catch (
      e
    ) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            e.message ??
                'Failed to update profile',
          ),
        ),
      );
    } catch (
      e
    ) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong',
          ),
        ),
      );
    }

    if (!mounted) return;

    setState(
      () {
        isSaving = false;
      },
    );
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.white54,
      ),
      filled: true,
      fillColor: const Color(
        0xFF0F1330,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
        borderSide: const BorderSide(
          color: Colors.white12,
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
        color: Colors.red,
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
          'Profile',
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
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
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
                          style: const TextStyle(
                            color: Colors.white,
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
                          style: const TextStyle(
                            color: Colors.white,
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
                          dropdownColor: const Color(
                            0xFF0F1330,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            labelStyle: const TextStyle(
                              color: Colors.white54,
                            ),
                            filled: true,
                            fillColor: const Color(
                              0xFF0F1330,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              borderSide: const BorderSide(
                                color: Colors.white12,
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
                          style: const TextStyle(
                            color: Colors.white,
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
                          style: const TextStyle(
                            color: Colors.white70,
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
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
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
