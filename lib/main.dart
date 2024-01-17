import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/utils/colors.dart';
import 'routes/app_routes.dart';
import 'screens/login/login_screen.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCYV_9fyVM03xCSg-cckj9a0W6us5LFqyY",
      appId: "1:116510620463:web:8ac15fc9b7eac1e6637fda",
      messagingSenderId: "116510620463",
      projectId: "creative-promotion",
      authDomain: "creative-promotion.firebaseapp.com",
      storageBucket: "creative-promotion.appspot.com",
      measurementId: "G-VY9J5RJ6H1",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Creative Promotion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.red),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      initialRoute: AppPages.initialroute,
      getPages: AppPages.pages,
    );
  }
}
