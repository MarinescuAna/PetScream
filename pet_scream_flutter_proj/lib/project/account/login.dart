import 'package:flutter/material.dart';
import 'package:pet_scream_flutter_proj/models/login-model.dart';
import 'package:pet_scream_flutter_proj/services/user_service.dart';

import '../../locator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  Future<String> myFuture;
  UserService _userService=locator<UserService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("PetScream", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            headerSelection(),
            textSelection(),
            buttonSection()
          ],
        ),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSelection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.email, color: Colors.black),
                hintText: "Email or phone number",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black)),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.black),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Container headerSelection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: Text(
        "Login",
        style: TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Colors.black,
        child: Text("Login", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
  signIn(String email, pass) async {
   myFuture=_userService.loginUser(UserLogin(
       email:email,
       password: pass)).then(
           (value) => null
   );
  }
}
