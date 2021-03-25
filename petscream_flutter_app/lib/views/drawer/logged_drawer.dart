import 'package:flutter/material.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';
import 'package:petscream_flutter_app/views/home/home.dart';
import 'package:petscream_flutter_app/views/posts/insert_post.dart';

class AccountUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: AssetImage("images/logoPetScream.png"),
                      fit: BoxFit.fill))),
          ListTile(
            title: Text('Home'),
            trailing: Icon(Icons.home),
          ),
          ListTile(
            title: Text('Post'),
            trailing: Icon(Icons.add_to_photos),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => InsertPost())
              );
            },
          ),
          ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: () {
                SingletonKeeper.SetToken(null);
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()
                ));
              }),
        ],
      ),
    );
  }
}
