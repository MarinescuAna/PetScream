import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petscream_flutter_app/locator/locator.dart';
import 'package:petscream_flutter_app/models/founder_model.dart';
import 'package:petscream_flutter_app/models/login_model.dart';
import 'package:petscream_flutter_app/services/ad_service.dart';
import 'package:petscream_flutter_app/services/user_service.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';
import 'package:petscream_flutter_app/toast/toaster.dart';
import 'package:petscream_flutter_app/views/home/home.dart';

class Found extends StatefulWidget {
  String id;

  Found(this.id);

  @override
  _FoundState createState() => _FoundState(id);
}

class _FoundState extends State<Found> {
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  Future<String> myFuture;
  AdService _service = locator<AdService>();
  String id;
  FlutterLocalNotificationsPlugin fltrNotification;
  _FoundState(this.id);
  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
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
          children: <Widget>[
            headerSelection(),
            textSelection(),
            _Back(context)
          ],
        ),
      ),
    );
  }
  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  Future _showNotification(String text) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "PetScream", "This is my channel",
        importance: Importance.High);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(androidDetails, iSODetails);

    await fltrNotification.show(
        0, "Information!", text,
        generalNotificationDetails, payload: "Information");
  }
  Container textSelection() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.black),
                  hintText: "Name",
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
              _space(),
              TextFormField(
                controller: phoneController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    icon: Icon(Icons.phone, color: Colors.black),
                    hintText: "Phone number",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black)),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length != 10) {
                    return "The number is invalid!!";
                  }
                  return null;
                },
              ),
              _space(),
              TextFormField(
                controller: addressController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.location_city, color: Colors.black),
                  hintText: "Address",
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
              )
            ],
          ),
        ));
  }

  Container headerSelection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: Text(
        "Where you can be found?",
        style: TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _space() {
    return SizedBox(
      height: 30,
    );
  }

  Padding _Back(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Row(children: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              ),
              child: Text("Back",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              }),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
            ),
            onPressed: () {
                    setState(() {
                      var obj=new FounderModel(
                          founderAddress: addressController.text,
                          founderName: nameController.text,
                          founderPhone: phoneController.text,
                          postID: id);
                      myFuture = _service.Found(obj)
                          .then((value) async {
                        if (value == "Success") {
                          _showNotification("Your data was sent: "+nameController.text+", "+addressController.text+", "+phoneController.text);
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()));
                        } else {
                          ShowToastComponent.showDialogError(value, context);
                        }
                      });
                    });
                  },
            child: Text("Sent data", style: TextStyle(color: Colors.white70)),
          )
        ]));
  }
}
