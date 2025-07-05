import 'package:asset_manager/controller/asesetsscreen_controller.dart';
import 'package:asset_manager/view/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
 await AssetController.openDb();
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
