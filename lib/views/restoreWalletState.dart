import 'package:absence_mobile_flutter/views/createPinState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../hdwallet/src/bip39/hdkey.dart';
import '../hdwallet/src/bip39/mnemonic.dart';

import "package:web3dart/conversions.dart";
import "package:web3dart/web3dart.dart";
import 'package:web3dart/src/utils/dartrandom.dart';

import 'package:ethereum/ethereum.dart';

import 'dart:math';

class RestoreWalletState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RestoreWalletStateState();
  }
}

class RestoreWalletStateState extends State<RestoreWalletState> {
  Future<List<String>> mnemonic() async {
    Random random = new Random.secure();
    List<String> a = (await MnemonicUtils.generateMnemonic(
            new DartRandom(random).nextBytes(32)))
        .toString()
        .split(new RegExp(r"\s"));
    return a;
  }
  static String mnemons = "";
  final one = TextEditingController();
  final two = TextEditingController();
  final three = TextEditingController();
  final four = TextEditingController();
  final five = TextEditingController();
  final six = TextEditingController();
  final seven = TextEditingController();
  final eight = TextEditingController();
  final nine = TextEditingController();
  final ten = TextEditingController();
  final eleven = TextEditingController();
  final twelve = TextEditingController();
  /* static */ List<String> mnemon = [];
  static List<String> pubMnemon = [];
  @override
  void initState() {
    super.initState();
    mnemonic().then((result) {
      setState(() {
        mnemon = result;
        //print(mnemon);
        mnemon = mnemon.getRange(0, 12).toList();
        pubMnemon = result.getRange(0, 12).toList();
      });
    });
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
                        minHeight: MediaQuery.of(ctx).size.height,
                        minWidth: MediaQuery.of(ctx).size.width,
                      ),
              child: new Container(
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
                  "Stage 1: Restoration",
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
                    "Enter the twelve words from a previous wallet you've used",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 40,
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
                          Container(
                              width: 100,
                              child: TextField(
                                controller: one,
                                decoration: InputDecoration(hintText: "1"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: three,
                                decoration: InputDecoration(hintText: "3"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: five,
                                decoration: InputDecoration(hintText: "5"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: seven,
                                decoration: InputDecoration(hintText: "7"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: nine,
                                decoration: InputDecoration(hintText: "9"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: eleven,
                                decoration: InputDecoration(hintText: "11"),
                              )),
                          SizedBox(
                            height: 70,
                          ),
                        ]),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: two,
                                decoration: InputDecoration(hintText: "2"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: four,
                                decoration: InputDecoration(hintText: "4"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: six,
                                decoration: InputDecoration(hintText: "6"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: eight,
                                decoration: InputDecoration(hintText: "8"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: ten,
                                decoration: InputDecoration(hintText: "10"),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                controller: twelve,
                                decoration: InputDecoration(hintText: "12"),
                              )),
                          SizedBox(
                            height: 70,
                          ),
                        ])
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                ButtonTheme(
                    buttonColor: Color.fromARGB(255, 21, 95, 220),
                    minWidth: 120,
                    height: 40,
                    child: RaisedButton(
                      onPressed: () {
                        if (one.text.trim() == "" || two.text.trim() == "" || three.text.trim() == "" || four.text.trim() == ""
                        ||five.text.trim() == ""||six.text.trim() == ""||seven.text.trim() == ""||eight.text.trim() == ""
                        ||nine.text.trim() == ""||ten.text.trim() == ""||eleven.text.trim() == ""||twelve.text.trim() == "") {
                        showDialog(
                          context: context,
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
                          }
                        );
                        } else {
                        mnemons = one.text + " " + two.text + " " +three.text + " " +four.text + " " +five.text + " " +six.text + " " +seven.text + " " +eight.text + " " +nine.text + " " +ten.text + " " +eleven.text + " " +twelve.text;
                          Navigator.of(context).pushNamed("/CreatePinState");
                        }
                      },
                      child: Text("CONTINUE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    )),
              ],
            )),
          ))));
        }));
  }
}
