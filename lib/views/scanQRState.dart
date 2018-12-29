import 'dart:async';

import 'package:absence_mobile_flutter/views/createPinState.dart';
import 'package:absence_mobile_flutter/views/createWalletState.dart';
import 'package:absence_mobile_flutter/views/enterPinState.dart';
import 'package:absence_mobile_flutter/views/mainWallet.dart';
import 'package:absence_mobile_flutter/views/restoreWalletState.dart';
import 'package:absence_mobile_flutter/views/setupState.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  ScanStateState createState() => new ScanStateState();
}

class ScanStateState extends State<ScanScreen> {
  static String barcode = "";
  static BuildContext ctxs;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctxs = context;
    return new MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 21, 95, 220),
            accentColor: Color.fromARGB(255, 21, 95, 220),
            hintColor: Colors.white),
        home: new Builder(builder: (ctx) {
          return new Scaffold(
              body: new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [Color(0xffb92b27), Color(0xff1565C0)],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                  child: new Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Text(
                          "Stage 1: The Sync",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 37,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w300),
                        )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                            "Sync the Absence Desktop Wallet with the Absence Mobile Wallet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w300)),
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "1. Go to settings",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 25,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("2. Export your wallet",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 25,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("3. Scan the QR Code",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 25,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 100,
                        ),
                        ButtonTheme(
                            buttonColor: Color.fromARGB(255, 21, 95, 220),
                            minWidth: 150,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () => scan(),
                              child: Text("SCAN NOW",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800)),
                            ))
                      ],
                    ),
                  )));
        }));
  }
}

Future scan() async {
  try {
    String barcodes = await BarcodeScanner.scan();
    // setState(() => this.barcode = barcode);
    if (barcodes.split(" ").length == 12) {
      ScanStateState.barcode = barcodes;
      print(barcodes);
      Navigator.of(ScanStateState.ctxs).pushNamed("/CreatePinState");
    } else {
      showDialog(
          context: ScanStateState.ctxs,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error"),
              content: new Text("Invalid Mnemonic"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      // setState(() {
      //   //this.barcode = 'The user did not grant the camera permission!';
      // });
    } else {
      //setState(() => this.barcode = 'Unknown error: $e');
    }
  } on FormatException {
    //setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
  } catch (e) {
    //setState(() => this.barcode = 'Unknown error: $e');
  }
}
