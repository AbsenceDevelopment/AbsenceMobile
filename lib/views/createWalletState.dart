import 'package:flutter/material.dart';
import '../hdwallet/src/bip39/hdkey.dart';
import '../hdwallet/src/bip39/mnemonic.dart';

import "package:web3dart/conversions.dart";
import "package:web3dart/web3dart.dart";
import 'package:web3dart/src/utils/dartrandom.dart';

import 'package:ethereum/ethereum.dart';

import 'dart:math';

class CreateWalletState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CreateWalletState();
  }
}

class _CreateWalletState extends State<CreateWalletState> {
  Future<List<String>> mnemonic() async {
    Random random = new Random.secure();
    List<String> a = (await MnemonicUtils.generateMnemonic(
            new DartRandom(random).nextBytes(32)))
        .toString()
        .split(new RegExp(r"\s"));
    return a;
  }

  List<String> mnemon = [];
  @override
  void initState() {
    super.initState();
    mnemonic().then((result) {
      setState(() {
        mnemon = result;
        print(mnemon);
        mnemon = mnemon.getRange(0, 12).toList();
        print(mnemon);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(fontFamily: 'OpenSans'),
        home: new Builder(builder: (ctx) {
          return new Scaffold(
              body: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Color(0xffb92b27), Color(0xff1565C0)],
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
                  "Stage 1: The Backup",
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
                    "These 12 words will hold all your funds, so store them in a safe place",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text("1.${mnemon[0]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("3.${mnemon[2]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("5.${mnemon[4]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("7.${mnemon[6]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("9.${mnemon[8]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("11.${mnemon[10]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 70,
                          ),
                        ]),
                        SizedBox(width: 50,),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text("2.${mnemon[1]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("4.${mnemon[3]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("6.${mnemon[5]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("8.${mnemon[7]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("10.${mnemon[9]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("12.${mnemon[11]}",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 30,
                                  color: Colors.white)),
                          SizedBox(
                            height: 70,
                          ),
                        ])
                  ],
                ),
                SizedBox (height: 20,),
                ButtonTheme(
                              buttonColor: Color.fromARGB(255, 21, 95, 220),
                              minWidth: 120,
                              height: 40,
                              child: RaisedButton(
                                onPressed: () => print("Hi"),
                                child: Text("Next",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              )),
              ],
            )),
          ));
        }));
  }
}
