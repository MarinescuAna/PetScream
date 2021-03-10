import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../posts.dart';

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
                     fit: BoxFit.fill
                 )
             )
          ),
          ListTile(
            title: Text('Home'),
            trailing: Icon(Icons.home),
          ),
          ListTile(
            title: Text('Post'),
            trailing: Icon(Icons.add_to_photos),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Post()));
            },
          ),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
