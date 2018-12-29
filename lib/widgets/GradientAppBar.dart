import 'package:absence_mobile_flutter/views/setupState.dart';
import 'package:flutter/material.dart';
import 'package:absence_mobile_flutter/main.dart';

class GradientAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: MediaQuery.of(context).padding.top + 80.0,
      color: Color.fromARGB(255, 21, 95, 220),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 56,),
          Align(
            alignment: Alignment.center,
          child: Text("Wallets",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Colors.white), textAlign: TextAlign.center,)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(children: <Widget>[
                      IconButton(
                      icon: Image.asset('assets/icons/new-wallet.png', scale: 4,),
                      onPressed: () {
                        Navigator.pushNamed(
                                        context, '/S');
                      },),
                      SizedBox(width: 24,),
                    ],),
                  )
        ]),
    );
  }
}
