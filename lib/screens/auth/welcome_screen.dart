import 'package:flutter/material.dart';

class WelcomeScreen
    extends
        StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<
    WelcomeScreen
  >
  createState() => _WelcomeScreenState();
}

class _WelcomeScreenState
    extends
        State<
          WelcomeScreen
        >
    with
        TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF070B2C,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(
            context,
          ).size.height,
        ),
      ),
    );
  }
}
