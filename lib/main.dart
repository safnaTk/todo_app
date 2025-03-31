import 'package:flutter/material.dart';
import 'package:todo_app/controller/todo_screen_controller.dart';

import 'package:todo_app/view/welcome_screen/welcome_screen.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();// binding class connect flutter frimework to the underlined plateform
 await TodoScreenController.openDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
