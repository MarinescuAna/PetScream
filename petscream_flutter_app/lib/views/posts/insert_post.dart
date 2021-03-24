

import 'package:flutter/material.dart';

class InsertPost extends StatefulWidget {
  @override
  _Insert createState() => _Insert();
}

class _Insert extends State<InsertPost> {
  Future<String> myFuture;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController petDescriptionController = new TextEditingController();
  final TextEditingController ownerAddressController = new TextEditingController();
  final TextEditingController lostPlaceController = new TextEditingController();
  var dateLostPet;

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      dateLostPet = order;
    });
  }
  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
  }

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
            children: <Widget>[headerSelection(), textSelection()],
          ),
        ),
      );
    }

    Container textSelection() {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: titleController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.title, color: Colors.black),
                      hintText: "Ad Title",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black)),
                  validator: (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: petDescriptionController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.pets, color: Colors.black),
                      hintText: "What your pet looks like?",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black)),
                  validator: (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: ownerAddressController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_city, color: Colors.black),
                      hintText: "Where you can be found?",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black)),
                  validator: (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: lostPlaceController,
                  cursorColor: Colors.black,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    icon: Icon(Icons.not_listed_location, color: Colors.black),
                    hintText: "Where you lost him?",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: dateLostPet == null
                            ? Text(
                          "Use below button to Select a Date"
                        )
                            : Text(
                          "$dateLostPet"
                        ),
                      ),
                      // ignore: deprecated_member_use
                      new RaisedButton(
                        onPressed: callDatePicker,
                        color: Colors.black,
                        child:
                        new Text('When you lost your pet?', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                    ),
                    onPressed: _formKey.currentState!=null && _formKey.currentState?.validate()
                        ? null
                        : () {
                      setState(() {
                         /*  myFuture = _userService.registerUser(UserRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            name: nameController.text)).then(
                                (value) async {
                              SingletonKeeper.SetToken(value.token);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage()
                              ));
                            }
                        );*/
                      });
                    },
                    child:  Text("Post", style: TextStyle(color: Colors.white70)),
                  ),
                )
              ],
            ),
          ));
    }

    Container headerSelection() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 30),
        child: Text(
          "Post a new ad",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );
    }
}