import 'package:flutter/material.dart';
import 'package:user_location_like_as_foodpanda/pages/splash_screen/splash_screen.dart';
import 'package:user_location_like_as_foodpanda/service/hive_service.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initHive();
  runApp(
      const MyApp()
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
