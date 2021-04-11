import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petscream_flutter_app/models/ad_rec_model.dart';
import 'package:photo_view/photo_view.dart';

class Ad extends StatelessWidget {
  AdRecModel model;

  Ad(this.model);

  var _width;
  var _heightScaleFactor;
  var _widthScaleFactor;
  var _height;
  var _orientation;

  @override
  Widget build(BuildContext context) {
    _processImageOrientation(context);
    return Column(
      children: [
        _showTitle(),
        _showDate(),
        _showImage(context),
        _showDescription(),
        _showButtom()
      ],
    );
  }

  void _processImageOrientation(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _orientation = MediaQuery.of(context).orientation;

    if (_orientation == Orientation.portrait) {
      _heightScaleFactor = 0.25;
      _widthScaleFactor = 1.0;
    } else {
      _heightScaleFactor = 0.5;
      _widthScaleFactor = 0.5;
    }
  }

  Widget _showImage(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          width: _width * _widthScaleFactor,
          height: _height * _heightScaleFactor,
          child: FittedBox(
            fit: BoxFit.contain,
            child: FittedBox(
              fit: BoxFit.contain,
              child: model.contentImage == null
                  ? Image.asset("images/noImage.jpg")
                  : Image.memory(
                      base64Decode(model.contentImage),
                      height: 10.0,
                      width: 10.0,
                    ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return FullScreenPoster(model.contentImage);
        }));
      },
    );
  }

  Padding _showButtom() {
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

  Text _showDescription() {
    return Text(
      model.petDescription,
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
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

class FullScreenPoster extends StatelessWidget {
  FullScreenPoster(this._poster);

  String _poster;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: showImage(_poster, MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
  }

  Container showImage(String image_string, double width, double height) {
    return Container(
      width: width,
      height: height,
      child: PhotoView(
        imageProvider: MemoryImage(base64Decode(image_string)),
      ),
    );
  }
}
