import 'package:absence_mobile_flutter/views/restoreWalletState.dart';
import 'package:flutter/material.dart';
import 'createWalletState.dart';
import 'package:flutter/cupertino.dart';
import 'scanQRState.dart';

class SetupState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SetupStateT();
  }
}

class SetupStateT extends State<SetupState> {
  static int option = 5;
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
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome to Absence",
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 37,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("The next generation Ethereum wallet",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 100.0,
                      ),
                      ButtonTheme(
                          height: 50,
                          minWidth: 300,
                          child: new RaisedButton(
                              color: Color.fromARGB(255, 255, 255, 255),
                              onPressed: () {
                                option = 0;
                                Navigator.of(context).pushNamed("/CreateWalletState");
                              },
                              child: Text("CREATE NEW WALLET",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 21, 95, 220),
                                      fontWeight: FontWeight.w700)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(60.0)))),
                      SizedBox(height: 15.0), //spacing
                      ButtonTheme(
                          height: 50,
                          minWidth: 300,
                          child: new RaisedButton(
                              color: Color.fromARGB(255, 255, 91, 115),
                              onPressed: () {
                                option = 1;
                                Navigator.of(context).pushNamed("/RestoreWalletState");
                              },
                              child: Text("RESTORE FROM MNEMONIC",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w700)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(60.0)))),
                      SizedBox(height: 15.0), //spacing
                      ButtonTheme(
                          height: 50,
                          minWidth: 300,
                          child: new RaisedButton(
                              //21, 81, 182
                              color: Color.fromARGB(255, 21, 81, 182),
                              onPressed: () {
                                option = 2;
                                  Navigator.of(context).pushNamed("/ScanQRState");
                              },
                              child: Text("SYNC WITH DESKTOP",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w700)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(60.0))))
                    ],
                  ))));
        }));
  }
}
