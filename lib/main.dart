import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/modules/main_screen/main_screen.dart';
import 'package:movies_app/modules/no_connection_screen/no_connection.dart';
import 'package:movies_app/styles/theme.dart';

Future<void> main() async {
  Widget? widget;
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    widget = const MainScreen();
  } else {
    widget = NoConnectionScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp(
    this.startWidget, {
    Key? key,
  }) : super(key: key);

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
        nextScreen: startWidget!,
        duration: 2000,
      ),
    );
  }
}
