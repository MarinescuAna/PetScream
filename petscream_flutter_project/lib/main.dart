import 'package:flutter/material.dart';
import 'package:petscream_flutter_project/project/account/login.dart';
import 'package:petscream_flutter_project/project/account/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
      home: MyHomePage(title: 'PetScream Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
              (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PetScream", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login()),
                      (Route<dynamic> route) => false);
            },

          ),
        ],
      ),
      body: Center(child: Text("Main Page")),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
             // child: Image.asset("images/logoPetScream.jpg"),
            ),
            ListTile(
              title: Text('Login'),
              trailing: Icon(Icons.login),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Login()
                ));
              },
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
            ),
            ListTile(
              title: Text('Register'),
              trailing: Icon(Icons.app_registration),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Register()
                ));
              },
            ),
            ListTile(
              title: Text('Home'),
              trailing: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Post'),
              trailing: Icon(Icons.add_to_photos),
            ),
          ],
        ),
      ),
    );
  }
}
