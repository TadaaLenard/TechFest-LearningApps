import 'package:flutter/material.dart';
import 'package:ilearn/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures asynchorous tasks are executed in correct order
  await dotenv.load(
      fileName: ".env"); // Load the .env file that contains Gemini API key
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iLearn',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'iLearn'),
    );
  }
}
