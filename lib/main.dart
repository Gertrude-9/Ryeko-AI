import 'package:flutter/material.dart';
import 'package:ryeko_ai/features/splash/presentation/screens/splash_screen.dart';
import 'package:ryeko_ai/features/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(const AgricultureAIApp());
}

class AgricultureAIApp extends StatelessWidget {
  const AgricultureAIApp({super.key});

  static const Color barColor = Color(0xff26ae60);
  static const Color bgColor = Color(0xffdae0e2);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)), // 3-second splash
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // Show splash
          } else {
            return const LoginScreen(); // After delay, go to login
          }
        },
      ),
    );
  }
}
