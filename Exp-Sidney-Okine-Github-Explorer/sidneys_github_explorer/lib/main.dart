import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sidneys_github_explorer/ux/navigation.dart';
import 'package:sidneys_github_explorer/ux/utils/constants_and_strings_file.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Navigation.entry,
      navigatorKey: Navigation.navigatorKey,
      onGenerateRoute: Navigation.onGenerateRoute,
    );
  }
}