import 'package:flutter/material.dart';
import 'createWalletState.dart';
import 'package:flutter/cupertino.dart';

class SetupState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SetupState();
  }
}

class _SetupState extends State<SetupState> {
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
                                Navigator.of(ctx, rootNavigator: true).push(
                                  new CupertinoPageRoute<bool>(
                                    fullscreenDialog: true,
                                    builder: (BuildContext contextt) =>
                                        new CreateWalletState(),
                                  ),
                                );
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
                              onPressed: () => print("Hi"),
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
                              onPressed: () => print("Hi"),
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
