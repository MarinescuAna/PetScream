import 'package:flutter/material.dart';
import 'package:pet_scream_flutter_proj/locator.dart';
import 'project/home_page/home_page.dart';
//>flutter run --no-sound-null-safety
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetScream',
      theme: ThemeData(
        accentColor: Colors.white70,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

