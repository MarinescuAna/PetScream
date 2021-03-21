
import 'package:flutter/material.dart';

 class AlertService {
  Widget ShowMyDialog(String content){
        return AlertDialog(
          content: Text(content),
          elevation: 24.0,
          backgroundColor: Colors.white,
          shape: CircleBorder(),
        );
      }
  }