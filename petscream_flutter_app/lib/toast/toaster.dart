
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ShowToastComponent {
  static showDialogSuccess(String msg, context) {
    Toast.show(
      msg,
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.green
    );
  }
  static showDialogInfo(String msg, context) {
    Toast.show(
        msg,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.yellow
    );
  }
  static showDialogError(String msg, context) {
    Toast.show(
        msg,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red
    );
  }
}