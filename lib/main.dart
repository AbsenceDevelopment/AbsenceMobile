
import 'dart:math';

import 'package:absence_mobile_flutter/views/createPinState.dart';
import 'package:absence_mobile_flutter/views/createWalletState.dart';
import 'package:absence_mobile_flutter/views/mainWallet.dart';
import 'package:absence_mobile_flutter/views/restoreWalletState.dart';
import 'package:absence_mobile_flutter/views/scanQRState.dart';
import 'package:absence_mobile_flutter/views/setupState.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absence_mobile_flutter/views/enterPinState.dart';

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
      return new MyAppS();
    }
}
class MyAppS extends State<MyApp> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  String a = "";
  SharedPreferences prefss;
  static bool setupComplete = false;
  @override
  void initState() {
    super.initState();
    prefs.then((result) {
      setState(() {
       prefss = result;
       setupComplete = result.getBool("setupComplete") != null && prefss.getBool("setupComplete") ? true : false;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    //getPrefs();
    //prefss.setBool("setupComplete", false);
    


    //var setupComplete = prefss.getBool("setupComplete") != null && prefss.getBool("setupComplete") ? true : false;
    //setupComplete = false;
    return new MaterialApp(
      home: setupComplete ? new EnterPinState() : SetupState(),
      routes: <String, WidgetBuilder>{
            "/CreatePinState": (BuildContext context) => CreatePinState(),
            "/CreateWalletState": (BuildContext context) => CreateWalletState(),
            "/EnterPinState": (BuildContext context) => EnterPinState(),
            "/MainWalletState": (BuildContext context) => MainWalletState(),
            "/RestoreWalletState": (BuildContext context) => RestoreWalletState(),
            "/ScanQRState": (BuildContext context) => ScanScreen(),
            "/SetupState": (BuildContext context) => SetupState(),
          },
    );
    // return new MaterialApp(
      
    //   home: Scaffold(
    //     body: Center(
          
    //     ),
    //   )
    // );
  }
}

