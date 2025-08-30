import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_app/presentation/screens/splash.dart';
import 'package:money_manager_app/service/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveCacheManager().init();
  runApp(
    const ProviderScope(
      // Wrap the app with ProviderScope for Riverpod
      child: MoneyTrackerApp(),
    ),
  );
}

class MoneyTrackerApp extends ConsumerWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
      title: 'Money Tracker',
      debugShowCheckedModeBanner: false,
      theme:
      // ThemeData(
      //   primarySwatch: Colors.yellow, // Primary color for accents
      //   scaffoldBackgroundColor: const Color(0xFF1C1C1C), // Dark background
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Color(0xFF1C1C1C),
      //     elevation: 0,
      //     titleTextStyle: TextStyle(
      //       color: Colors.white,
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     iconTheme: IconThemeData(color: Colors.white),
      //   ),
      //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //     backgroundColor: const Color(0xFF2C2C2C), // Darker bottom nav
      //     selectedItemColor: Colors.yellow.shade700, // Yellow for selected
      //     unselectedItemColor: Colors.grey, // Grey for unselected
      //     type: BottomNavigationBarType.fixed, // Fixed type to show all labels
      //     selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     backgroundColor: Colors.yellow.shade700, // Yellow FAB
      //     foregroundColor: Colors.black, // Black icon on FAB
      //     shape: const CircleBorder(), // Circular FAB
      //   ),
      //   cardTheme: CardTheme(
      //     color: const Color(0xFF2C2C2C), // Darker card background
      //     elevation: 4,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //   ),
      //   textTheme: const TextTheme(
      //     bodyLarge: TextStyle(color: Colors.white),
      //     bodyMedium: TextStyle(color: Colors.white70),
      //     titleLarge: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     titleMedium: TextStyle(color: Colors.white),
      //     labelLarge: TextStyle(color: Colors.white),
      //   ),
      //   dividerColor: Colors.grey.shade800, // Subtle dividers
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: Colors.yellow,
      //   ).copyWith(
      //     secondary: Colors.yellow.shade700, // Accent color
      //     background: const Color(0xFF1C1C1C), // Background color
      //   ),
      // ),
      ThemeData(
        // Primary color for accents - A shade of green/teal as seen in the image for accents
        primarySwatch: Colors.teal, // This will generate various shades of teal
        // Scaffold background color - Light grey/white as in the image
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),

        // A very light grey/off-white
        appBarTheme: const AppBarTheme(
          // AppBar background color - White as in the image
          backgroundColor: Colors.white,
          elevation: 0, // No shadow for a flat look
          titleTextStyle: TextStyle(
            color: Colors.black, // Dark text for app bar title
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ), // Dark icons for app bar
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          // Bottom nav background - White
          backgroundColor: Colors.white,
          // Selected item color - A green/teal shade similar to the income card
          selectedItemColor: const Color(
            0xFF116D6E,
          ), // The teal from your balance card
          // Unselected item color - Grey for contrast
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          // FAB background color - Green/Teal from the image
          backgroundColor: const Color(0xFF116D6E), // Matches the card color
          foregroundColor: Colors.white, // White icon on FAB
          shape: const CircleBorder(), // Circular FAB
        ),

        cardTheme: const CardThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),

        textTheme: GoogleFonts.robotoCondensedTextTheme(),
        dividerColor: Colors.grey.shade300, // Light grey dividers

        colorScheme: ColorScheme.fromSwatch(
          // Use teal as the primary swatch for the light theme
          primarySwatch: Colors.teal,
        ).copyWith(
          // Accent color - The teal from the balance card/FAB
          secondary: const Color(0xFF116D6E),
          // Background color - Consistent with scaffold background
          background: const Color(0xFFF0F2F5),
          // Adjust onSurface for text on cards, etc., if needed
          onSurface: Colors.black87,
          // Adjust surface for card-like elements
          surface: Colors.white,
        ),
      ),
      home: const PreScreen(),
    );
  }
}
