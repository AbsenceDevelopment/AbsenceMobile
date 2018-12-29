import 'dart:convert';

import 'package:absence_mobile_flutter/main.dart';
import 'package:absence_mobile_flutter/views/enterPinState.dart';
import 'package:absence_mobile_flutter/views/restoreWalletState.dart';
import 'package:absence_mobile_flutter/views/scanQRState.dart';
import 'package:absence_mobile_flutter/views/setupState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'createWalletState.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dbcrypt/dbcrypt.dart';

class CreatePinState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CreatePinState();
  }
}

class _CreatePinState extends State<CreatePinState> {
  final passwordFirst = TextEditingController();
  final passwordSecond = TextEditingController();
  final storage = new FlutterSecureStorage();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  SharedPreferences prefss;
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    passwordFirst.dispose();
    passwordSecond.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefs.then((result) {
      setState(() {
        prefss = result;
      });
    });
    // if (SetupStateT.option == 2) if (RegExp("/\S/")
    //     .hasMatch(ScanStateState.barcode))
    //   Navigator.of(context).pushNamed("/SetupState");
    // if (SetupStateT.option == 0) if (RegExp("/\S/")
    //     .hasMatch(CreateWalletStateState.pubMnemon.join(" ")))
    //   Navigator.of(context).pushNamed("/SetupState");
    // if (SetupStateT.option == 1) if (RegExp("/\S/")
    //     .hasMatch(RestoreWalletStateState.mnemons))
    //   Navigator.of(context).pushNamed("/SetupState");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 21, 95, 220),
            accentColor: Color.fromARGB(255, 21, 95, 220),
            hintColor: Colors.white),
        home: new Builder(builder: (ctx) {
          return new Scaffold(
              body: new SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Container(
                          decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Color(0xffb92b27),
                                    Color(0xff1565C0)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp)),
                          child: Center(
                              child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Text(
                                  "Stage 2: The Protection",
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 37,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                    "This passcode will keep your funds safe from intruders",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.w300)),
                                SizedBox(
                                  height: 120,
                                ),
                                Container(
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Please enter a password",
                                          border: UnderlineInputBorder()),
                                      controller: passwordFirst,
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      cursorColor:
                                          Color.fromARGB(255, 21, 95, 220),
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText:
                                              "Please confirm your password"),
                                      controller: passwordSecond,
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                    )),
                                SizedBox(
                                  height: 120,
                                ),
                                ButtonTheme(
                                    buttonColor:
                                        Color.fromARGB(255, 21, 95, 220),
                                    child: RaisedButton(
                                      child: Text(
                                        "FINISH",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        //print("1:${passwordFirst.text} 2:${passwordSecond.text}");
                                        if (passwordFirst.text ==
                                            passwordSecond.text) {
                                          if (SetupStateT.option == 0) {
                                            var mnemonic = new List<String>();
                                            mnemonic.add(CreateWalletStateState.pubMnemon
                                                    .join(" "));
                                            storage.write(
                                                key: "mnemonic",
                                                value: json.encode(mnemonic));
                                            print("Written Mnemonic");
                                            storage.write(
                                                key: "hashedPW",
                                                value: new DBCrypt().hashpw(
                                                    passwordFirst.text,
                                                    new DBCrypt().gensalt()));
                                            print("Written Password");
                                            prefss.setBool(
                                                "setupComplete", true);
                                          } else if (SetupStateT.option == 1) {
                                            var mnemonic = new List<String>();
                                            mnemonic.add(RestoreWalletStateState.mnemons);
                                            storage.write(
                                                key: "mnemonic",
                                                value: json.encode(mnemonic));
                                            print("Written Mnemonic");
                                            storage.write(
                                                key: "hashedPW",
                                                value: new DBCrypt().hashpw(
                                                    passwordFirst.text,
                                                    new DBCrypt().gensalt()));
                                            print("Written Password");
                                            prefss.setBool(
                                                "setupComplete", true);
                                          } else {
                                            var mnemonic = new List<String>();
                                            mnemonic.add(ScanStateState.barcode);
                                            storage.write(
                                                key: "mnemonic",
                                                value: json.encode(mnemonic));
                                            print("Written Mnemonic");
                                            storage.write(
                                                key: "hashedPW",
                                                value: new DBCrypt().hashpw(
                                                    passwordFirst.text,
                                                    new DBCrypt().gensalt()));
                                            print("Written Password");
                                            prefss.setBool(
                                                "setupComplete", true);
                                          }
                                          Navigator.of(context)
                                              .pushNamed("/EnterPinState");
                                        } else {
                                          showDialog(
                                              context: ScanStateState.ctxs,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: new Text("Error"),
                                                  content: new Text(
                                                      "Passwords do not match"),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("Close"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                      },
                                    ))
                              ]))))));
        }));
  }
}
