import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petscream_flutter_app/models/ad_rec_model.dart';
import 'package:petscream_flutter_app/views/home/ad_page.dart';
import 'package:petscream_flutter_app/views/home/image.dart';
import 'package:photo_view/photo_view.dart';

class Ad extends StatelessWidget {
  AdRecModel model;

  Ad(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _showTitle(),
        _showDate(),
        _showPlace(),
         ShowImage(model.contentImage),
        _showButtom(context)
      ],
    );
  }

  Padding _showButtom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
        ),
        child: Text("View",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => AdPage(model)));
          }
      ),
    );
  }

  Text _showDate() {
    return Text(
      model.postDatetime.toString().split('T')[0] +
          " " +
          model.postDatetime.toString().split('T')[1].split(':')[0] +
          ":" +
          model.postDatetime.toString().split('T')[1].split(':')[1],
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 10.0),
    );
  }

  Text _showPlace() {
    return Text("Place: " +
      model.lostPlaceAddress,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 15.0),
    );
  }

  Row _showTitle() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: model.status == "Lost"
              ? Icon(Icons.notification_important, color: Colors.red)
              : Icon(Icons.check, color: Colors.green),
        ),
        Expanded(
          child: Text(
            model.title.toUpperCase() + "  ",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
