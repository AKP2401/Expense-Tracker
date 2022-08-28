import 'package:ex_track/data/transaction.dart';
import 'package:ex_track/data/transaction_service.dart';
import 'package:ex_track/pages/main_page.dart';
import 'package:ex_track/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  runApp(
    ListenableProvider(
      child: const MyApp(),
      create: (context) => TransactionService(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        'home': (context) => const MainPage(),
      },
    );
  }
}
