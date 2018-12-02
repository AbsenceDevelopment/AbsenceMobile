
import 'dart:math';

import 'package:absence_mobile_flutter/views/setupState.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() { 
  runApp(new MyApp()); 
}

class MyApp extends StatefulWidget {
  // SharedPreferences prefs;
  // Future<void> getPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  // }
  @override
    State<StatefulWidget> createState() {
      return new _MyApp();
    }
}
class _MyApp extends State<MyApp> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String a = "";
  SharedPreferences prefss;
  @override
  void initState() {
    super.initState();
    prefs.then((result) {
      setState(() {
       prefss = result;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    //getPrefs();
    // prefss.setBool("a", true);
    


    var setupComplete = prefss.getBool("setupComplete") != null && prefss.getBool("setupComplete") ? true : false;
    if (setupComplete) {
      return null;
    } else {
      print("HII");
      return new SetupState();
    }
    // return new MaterialApp(
      
    //   home: Scaffold(
    //     body: Center(
          
    //     ),
    //   )
    // );
  }
}

