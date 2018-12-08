import 'package:absence_mobile_flutter/views/mainWallet.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EnterPinState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _EnterPinState();
  }
}

class _EnterPinState extends State<EnterPinState>
    with SingleTickerProviderStateMixin {
  final storage = new FlutterSecureStorage();
  final password = TextEditingController();
  var hashedPW = "";
  var y = 0;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
    storage.read(key: "hashedPW").then((result) {
      hashedPW = result;
      // print("A $result");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
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
            child: Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [Color(0xff2f3136), Color(0xff2f3136)],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp)),
                //child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(ctx).size.width / 16),
                        Text(
                          "SIGN IN",
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 45,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    new Column(children: <Widget>[
                      Row(children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(ctx).size.width / 6.5,
                        ),
                        Text("PASSWORD",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16)),
                      ]),
                      Row(children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(ctx).size.width / 24,
                        ),
                        new AnimatedBuilder(
                            animation: offsetAnimation,
                            builder: (buildContext, child) {
                              if (offsetAnimation.value < 0.0)
                                print('${offsetAnimation.value + 8.0}');
                              return Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 24.0),
                                  padding: EdgeInsets.only(
                                      left: offsetAnimation.value + 24.0,
                                      right: 24.0 - offsetAnimation.value),
                                  width: 300,
                                  child: new TextField(
                                    controller: password,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder()),
                                    obscureText: true,
                                    textAlign: TextAlign.center,
                                    cursorColor:
                                        Color.fromARGB(255, 21, 95, 220),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ));
                            }),
                        SizedBox(
                          width: MediaQuery.of(ctx).size.width / 24,
                        ),
                      ])
                    ]),
                    Center(
                        child: ButtonTheme(
                            minWidth: 250,
                            height: 70,
                            buttonColor: Color(0xff21242c),
                            child: new RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(250.0)),
                              child: y == 0
                                  ? new Text(
                                      "UNLOCK",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : new CircularProgressIndicator(),
                              onPressed: () async {
                                setState(() {
                                  y = 1;
                                });
                                await new Future.delayed(
                                    const Duration(seconds: 1));
                                if (new DBCrypt()
                                    .checkpw(password.text, hashedPW)) {
                                  //print("Correct");
                                  Navigator.of(context)
                                      .pushReplacementNamed("/MainWalletState");
                                } else {
                                  //print("Incorrect");
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return new AlertDialog(
                                  //         title: new Text("Error"),
                                  //         content: new Text(
                                  //             "Password is incorrect"),
                                  //         actions: <Widget>[
                                  //           new FlatButton(
                                  //             child: new Text("Close"),
                                  //             onPressed: () {
                                  //               Navigator.of(context).pop();
                                  //             },
                                  //           )
                                  //         ],
                                  //       );
                                  //     });
                                  controller.forward(from: 0.0);
                                  setState(() {
                                    y = 0;
                                  });
                                  //controller.forward(from: 0.0);
                                }
                              },
                            ))),
                    SizedBox(
                      height: MediaQuery.of(ctx).size.height / 18,
                    )
                  ],
                )),
          )));
        }));
  }
}
