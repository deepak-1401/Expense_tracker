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
  String? selectedGender;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(
                    8.0,
                  ),
                ),
                // Add profile details
                const SizedBox(
                  height: 20,
                ),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/profile_picture.png',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  //  controller: nameController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "name",
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
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  //  controller: nameController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "age",
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
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: Colors.red,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(
                  height: 30,
                ),

                DropdownButtonFormField<
                  String
                >(
                  initialValue: widget.selectedGender,

                  decoration: InputDecoration(
                    labelText: "Gender",
                    // prefixIcon: const Icon(
                    //   Icons.wc_rounded,
                    //   color: Colors.red,
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),

                  items: const [
                    DropdownMenuItem(
                      value: "Male",
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
                            "Male",
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Female",
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
                            "Female",
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Other",
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
                            "transgender",
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
                  //  controller: nameController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Occupation",
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
                    prefixIcon: const Icon(
                      Icons.work,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
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
                              Color(
                                0xFF8B5CF6,
                              ).withValues(
                                alpha: 0.35,
                              ),
                          blurRadius: 15,
                          offset: Offset(
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
                      ),
                      onPressed: () {
                        // Handle save action
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
