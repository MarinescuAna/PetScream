import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petscream_flutter_app/models/ad_rec_model.dart';
import 'package:photo_view/photo_view.dart';

class ShowImage extends StatelessWidget {
  String base64content;

  ShowImage(this.base64content);

  var _width;
  var _heightScaleFactor;
  var _widthScaleFactor;
  var _height;
  var _orientation;

  @override
  Widget build(BuildContext context) {
    _processImageOrientation(context);
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
              child: base64content == null
                  ? Image.asset("images/noImage.jpg")
                  : Image.memory(
                base64Decode(base64content),
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
              return FullScreenPoster(base64content);
            }));
      },
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
