import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager_app/presentation/screens/login.dart';
import 'package:money_manager_app/utils/color.dart';

class PreScreen extends StatefulWidget {
  const PreScreen({super.key});

  @override
  State<PreScreen> createState() => _PreScreenState();
}

class _PreScreenState extends State<PreScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.off(() => const LoginScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: MediaQuery.of(context).size.height * 0.13),
          Center(
            child: Image.asset(
              'assets/images/wallet.png',
              width: 60,
              height: 60,
              scale: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
