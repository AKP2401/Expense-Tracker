import 'dart:async';

import 'package:ex_track/pages/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => const MainPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amberAccent,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/budgeting.png',
              width: 200,
            ),
            const SizedBox(
              height: 30,
            ),
            const Hero(
                // flightShuttleBuilder: HeroFlightShuttleBuilder.(flightContext, animation, flightDirection, fromHeroContext, toHeroContext){},
                tag: 'balance',
                child: Text(
                  'Expense Tracker',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ))
          ]),
        ),
      ),
    );
  }
}
