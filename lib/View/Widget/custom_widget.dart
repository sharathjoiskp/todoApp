import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class showToast {
  void failToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent[500],
      //textColor: Colors.black,
      // fontSize: 16.0,
    );
  }

  successToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.greenAccent[500],
      // textColor: Colors.black,
      //fontSize: 16.0,
    );
  }
}
