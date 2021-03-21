import 'package:flutter/material.dart';
import 'package:pet_scream_flutter_proj/models/login-model.dart';
import 'package:pet_scream_flutter_proj/services/alert_service.dart';
import 'package:pet_scream_flutter_proj/services/user_service.dart';

import '../../locator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  Future<String> myFuture;
  final _formKey = GlobalKey<FormState>();
  UserService _userService=locator<UserService>();
  AlertService _alertService=locator<AlertService>();

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
            textSelection()
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
      child: Form(
        key: _formKey,
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
                  hintStyle: TextStyle(color: Colors.black)
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if(!validateEmail(value)) {
                  return "Invalid email!!";
                }
                return null;
              },
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
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 6) {
                  return "Password should be at least 6 characters";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
                onPressed: _formKey.currentState!=null && !_formKey.currentState?.validate()
                    ? null
                    : () {
                  setState(() {
                    _isLoading = true;
                    signIn(emailController.text, passwordController.text);
                  });
                },
                child:  Text("Login", style: TextStyle(color: Colors.white70)),
              ),
            )
          ],
        ),
      )
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

  bool validateEmail(String value) {
    Pattern pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  signIn(String email, pass) async {
   myFuture=_userService.loginUser(UserLogin(
       email:email,
       password: pass)).then(
           (value) => null
   );
  }
}
