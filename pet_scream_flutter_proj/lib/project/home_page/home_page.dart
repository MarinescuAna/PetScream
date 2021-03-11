
import 'package:flutter/material.dart';
import 'package:pet_scream_flutter_proj/project/drawer/guest_drawer.dart';
import 'package:pet_scream_flutter_proj/project/drawer/logged_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("PetScream", style: TextStyle(color: Colors.white)),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      drawer: AccountUI()
    );
  }
}
