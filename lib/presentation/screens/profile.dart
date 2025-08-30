

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:money_manager_app/presentation/screens/login.dart';
import 'package:money_manager_app/provider/common.dart';
import 'package:money_manager_app/provider/user_provider.dart';
import 'package:money_manager_app/utils/color.dart';

// //final userServiceProvider = Provider((ref) => UserService());
// final userProfileProvider = FutureProvider<UserModel>((ref) async {
//   return await UserService.fetchDashboardData();
// });



class Setting extends ConsumerWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userDataProvider);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: userProfile.when(
            data:
                (user) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/rose.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                user.email,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                user.role,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 75, 244, 162),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildSettingItem(Icons.person, "Account Info"),
                    buildSettingItem(Icons.language, "Language".tr),
                    buildSettingItem(Icons.help_outline, "Help & feedback".tr),
                    buildSettingItem(
                      Icons.privacy_tip_outlined,
                      "Privacy & policy".tr,
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 0;
                        Get.to(() => const LoginScreen());
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Logout'.tr,
                              style: const TextStyle(
                                fontFamily: 'Century',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ),
    );
  }

  Widget buildSettingItem(IconData icon, String title) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black),
            const SizedBox(width: 29),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
