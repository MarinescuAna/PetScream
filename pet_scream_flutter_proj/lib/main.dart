import 'package:flutter/material.dart';
import 'package:pet_scream_flutter_proj/project/account/login.dart';
import 'package:pet_scream_flutter_proj/project/account/register.dart';
import 'package:photo_view/photo_view.dart';

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
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PhotoView(
                      imageProvider: AssetImage("images/logoPetScream.png")
                    ),
                  )
                ],
              ),
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
