
import 'package:flutter/material.dart';
import 'package:petscream_flutter_app/views/account/login.dart';
import 'package:petscream_flutter_app/views/account/register.dart';

class NoAccountUI extends StatelessWidget{

  @override
  Widget build(BuildContext context){
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
            title: Text('Login'),
            trailing: Icon(Icons.login),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                  builder: (BuildContext context) => Login()
              ));
            },
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
        ],
      ),
    );
  }
}