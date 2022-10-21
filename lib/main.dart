import 'package:flutter/material.dart';
import 'package:qatar_quran_memorization/database/database_controller.dart';
import 'package:qatar_quran_memorization/prefernces/shared_pref_controller.dart';
import 'package:qatar_quran_memorization/screen/app/home_screen.dart';
import 'package:qatar_quran_memorization/screen/app/student_screen.dart';
import 'package:qatar_quran_memorization/screen/auth/login_screen.dart';
import 'package:qatar_quran_memorization/screen/auth/register_screen.dart';
import 'package:qatar_quran_memorization/screen/launch_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  await DBController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [const Locale('ar')],
      locale: const Locale('ar'),
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/student_screen': (context) => const StudentScreen(),
      },
    );
  }
}
