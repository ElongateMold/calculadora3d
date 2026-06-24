import 'package:flutter/material.dart';
import 'screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'package:provider/provider.dart';
import 'package:calculartor3d/providers/filament_provider.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilamentProvider()),
      ],
      child: const Calculator3DApp(),
    ),
  );
}

class Calculator3DApp extends StatelessWidget {
  const Calculator3DApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier, 
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'THREED',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            scaffoldBackgroundColor: AppColors.background,
            textTheme: GoogleFonts.latoTextTheme(),
            appBarTheme: AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: AppColors.textDark,),
            useMaterial3: true,
          ),
          darkTheme: ThemeData (
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryDark,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: AppColors.backgroundDark,

            textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primaryDark,
              foregroundColor: AppColors.textDark,
            ),
            useMaterial3: true,

          ),
          themeMode: currentMode,

          home: const StartScreen(),
        );
      },
    );
  }
}