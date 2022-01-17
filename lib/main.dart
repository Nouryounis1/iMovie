import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/modules/main_screen/main_screen.dart';
import 'package:movies_app/styles/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: AnimatedSplashScreen(
        splash: SizedBox(
          child: Lottie.asset('assets/92678-movie.json'),
        ),
        splashIconSize: double.infinity,
        backgroundColor: HexColor('030002'),
        nextScreen: const MainScreen(),
        duration: 2000,
      ),
    );
  }
}
