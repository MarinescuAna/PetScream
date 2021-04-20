import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';
import 'package:petscream_flutter_app/views/drawer/guest_drawer.dart';
import 'package:petscream_flutter_app/views/drawer/logged_drawer.dart';
import 'package:petscream_flutter_app/views/home/ads_page.dart';
import 'package:petscream_flutter_app/views/posts/insert_post.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: new Stack(
        children: <Widget>[
         new Container(
           decoration: buildBoxDecoration()
         ),
          new Ads()
        ],
      ),
      drawer: SingletonKeeper.IsLogged() == false ? NoAccountUI() : AccountUI(),
      floatingActionButton: new Visibility(
        visible: SingletonKeeper.IsLogged(),
        child: buildFloatingActionButton(),
      ),
    );
  }


  BoxDecoration buildBoxDecoration() {
    return new BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/background.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => InsertPost()));
      },
      child: Icon(Icons.post_add),
      backgroundColor: Colors.grey,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey,
      title: Text("PetScream", style: TextStyle(color: Colors.white)),
    );
  }
}
