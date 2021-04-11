import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petscream_flutter_app/locator/locator.dart';
import 'package:petscream_flutter_app/models/post_sender_model.dart';
import 'package:petscream_flutter_app/services/ad_service.dart';
import 'package:petscream_flutter_app/toast/toaster.dart';
import 'package:petscream_flutter_app/views/home/home.dart';

class InsertPost extends StatefulWidget {
  @override
  _Insert createState() => _Insert();
}

class _Insert extends State<InsertPost> {
  AdService _adService = locator<AdService>();
  Future<String> myFuture;
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController petDescriptionController =
      new TextEditingController();
  final TextEditingController ownerAddressController =
      new TextEditingController();
  final TextEditingController lostPlaceController = new TextEditingController();
  var dateLostPet;
  File _image;

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

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Post a new ad", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: _textSelection()),
    );
  }

  Container _textSelection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(children: <Widget>[
              _showImageButtonPiker(),
              _showDateTimePicker()
            ]),
          ),
          _insertSpace(),
          TextField(
            controller: titleController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.title, color: Colors.black),
                hintText: "Ad Title",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black)),
          ),
          _insertSpace(),
          TextField(
            controller: petDescriptionController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.pets, color: Colors.black),
                hintText: "What your pet looks like?",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black)),
          ),
          _insertSpace(),
          TextField(
            controller: ownerAddressController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.location_city, color: Colors.black),
                hintText: "Where you can be found?",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black)),
          ),
          _insertSpace(),
          TextField(
            controller: lostPlaceController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.not_listed_location, color: Colors.black),
              hintText: "Where you lost him?",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          _insertSpace(),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: _buttonPost())
        ],
      ),
    );
  }

  Widget _buttonPost() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
      ),
      onPressed: ownerAddressController.text != null &&
              lostPlaceController.text != null &&
              petDescriptionController.text != null &&
              titleController.text != null &&
              dateLostPet != null &&
              _image != null
          ? null
          : () {
              setState(() {
                var split = _image.path.split('/');
                Uint8List _CV = File(_image.path).readAsBytesSync();
                String _CV_string = base64Encode(_CV);
                PostSender postAd = PostSender(
                    binaryContentImage: _CV_string,
                    imageName: split[split.length - 1].split('.')[0],
                    extentionImage: split[split.length - 1].split('.')[1],
                    title: titleController.text,
                    petDescription: petDescriptionController.text,
                    lostPlaceAddress: lostPlaceController.text,
                    ownerAddress: ownerAddressController.text,
                    lostDatetime: dateLostPet.toString());
                myFuture = _adService.insertAd(postAd).then((value) async {
                  if(value=="Success"){
                    ShowToastComponent.showDialogSuccess(value, context);
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                  }else{
                    ShowToastComponent.showDialogError(value, context);
                  }

                });
              });
            },
      child: Text("Post", style: TextStyle(color: Colors.white70)),
    );
  }

  Widget _insertSpace() {
    return SizedBox(
      height: 20,
    );
  }

  Widget _showImageButtonPiker() {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.grey,
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
      ),
    );
  }

  Widget _showDateTimePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: dateLostPet == null
              ? Text("When you lost your pet")
              : Text(dateLostPet.toString().split(" ")[0]),
        ),
        // ignore: deprecated_member_use
        new RaisedButton(
          onPressed: callDatePicker,
          color: Colors.grey,
          child: Icon(Icons.calendar_today_outlined, color: Colors.white70),
        ),
      ],
    );
  }
}
