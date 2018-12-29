import 'dart:convert';

import 'package:absence_mobile_flutter/hdwallet/src/bip39/hdkey.dart';
import 'package:absence_mobile_flutter/hdwallet/src/bip39/mnemonic.dart';
import 'package:absence_mobile_flutter/views/createPinState.dart';
import 'package:absence_mobile_flutter/views/createWalletState.dart';
import 'package:absence_mobile_flutter/views/enterPinState.dart';
import 'package:absence_mobile_flutter/views/restoreWalletState.dart';
import 'package:absence_mobile_flutter/views/scanQRState.dart';
import 'package:absence_mobile_flutter/views/setupState.dart';
import 'package:absence_mobile_flutter/widgets/GradientAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:web3dart/web3dart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../classes/getTokens.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:rounded_modal/rounded_modal.dart';
import 'package:modal_drawer_handle/modal_drawer_handle.dart';

class MainWalletState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainWalletStateState();
  }
}

class Rates {
  final rate;
  final cur;
  Rates(this.rate, this.cur);
}

class MainWalletStateState extends State<MainWalletState> {
  final storage = new FlutterSecureStorage();
  List mnemonics;
  static Credentials currentWallet;
  static int selectedCur = 10;
  static var _icons = [
    'assets/icons/wallet-selected@2.png',
    'assets/icons/wallet-deselected@2.png',
    'assets/icons/settings-selected@2.png',
    'assets/icons/settings-deselected@2.png',
  ];
  var _walIcon = _icons[0];
  var _setIcon = _icons[3];
  var currencies = [
    "USD",
    "AUD",
    "BRL",
    "CAD",
    "CHF",
    "CLP",
    "CNY",
    "CZK",
    "DKK",
    "EUR",
    "GBP",
    "HKD",
    "HUF",
    "IDR",
    "ILS",
    "INR",
    "JPY",
    "KRW",
    "MXN",
    "MYR",
    "NOK",
    "NZD",
    "PHP",
    "PKR",
    "PLN",
    "RUB",
    "SEK",
    "SGD",
    "THB",
    "TRY",
    "TWD",
    "ZAR"
  ];
  static GetTokens getToken;
  static bool loaded = false;
  int y = 1;
  List<Rates> rates = new List();
  var c;
  var getToke;
  @override
  void initState() {
    storage.read(key: "mnemonic").then((result) {
      setState(() {
        mnemonics = jsonDecode(result);
        // var seed = MnemonicUtils.generateMasterSeed(mnemonics[0], "");
        // var rootSeed = getRootSeed(seed);
        // var priv = EthereumStandardHDWalletPath((rootSeed));
        // currentWallet = Credentials.fromPrivateKeyHex(priv);
        mnemonics.add(
            "bonus divide ability above attract silent valid hope almost video december debate");
        print(mnemonics.length);
      });
    });

    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      setState(() {
        y = 1;
      });
      getStuff(0);
      new Future.delayed(const Duration(seconds: 5)).whenComplete(() {
        setState(() {
          y = 0;
        });
      });
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        routes: <String, WidgetBuilder>{
          "/CreatePinState": (BuildContext context) => CreatePinState(),
          "/CreateWalletState": (BuildContext context) => CreateWalletState(),
          "/EnterPinState": (BuildContext context) => EnterPinState(),
          "/MainWalletState": (BuildContext context) => MainWalletState(),
          "/RestoreWalletState": (BuildContext context) => RestoreWalletState(),
          "/ScanQRState": (BuildContext context) => ScanScreen(),
          "/SetupState": (BuildContext context) => SetupState(),
        },
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 21, 95, 220),
            accentColor: Color.fromARGB(255, 21, 95, 220),
            hintColor: Colors.white),
        home: new Builder(builder: (ctx) {
          return new Scaffold(
              backgroundColor: Colors.white,
              // appBar: new PreferredSize(
              //   preferredSize: Size(MediaQuery.of(context).size.width, 70),

              //   child: AppBar(
              //     centerTitle: true,
              //     title: new Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       Text("Wallets",
              //           style: TextStyle(
              //               fontFamily: 'Poppins',
              //               fontWeight: FontWeight.w600,
              //               fontSize: 35))
              //     ],
              //   ),
              // ))),
              body: Stack(children: <Widget>[
                // SizedBox(
                //   height: MediaQuery.of(context).padding.top + 66.0,
                // ),
                new Container(
                    // decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         colors: [
                    //           const Color(0xff3366ff),
                    //           const Color(0xff00ccff)
                    //         ],
                    //         begin: const FractionalOffset(0.0, 0.0),
                    //         end: const FractionalOffset(1.0, 0.0),
                    //         stops: [0.0, 1.0],
                    //         tileMode: TileMode.clamp)),
                    color: Color.fromARGB(255, 252, 251, 255),
                    child: Column(children: <Widget>[
                      new GradientAppBar(),
                      new Container(
                        padding: EdgeInsets.only(bottom: 5, top: 10),
                        child: new Center(
                            child: _buildCarousel(
                                context, 0, mnemonics.length, mnemonics)),
                        //color: Colors.red,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: new Row(children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            new Text(
                              "Tokens",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 192, 190, 202),
                                  fontWeight: FontWeight.w700),
                            )
                          ])),
                      //new SizedBox(height: 50,),
                      //138,216,35
                      new Expanded(
                          child: new Container(
                              //padding: EdgeInsets.only(top: 20),
                              child: new Center(
                                  child: y == 0
                                      ? getToken != null
                                          ? new Container(
                                              child: Column(
                                              children: <Widget>[
                                                new Flexible(
                                                    child: ListView.builder(
                                                  padding: EdgeInsets.all(10),
                                                  itemCount: getToken.tokens !=
                                                          null
                                                      ? getToken.tokens.length
                                                      : 1,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int itemIndex) {
                                                    if (itemIndex == 0) {
                                                      return new Card(
                                                          color: Color.fromARGB(
                                                              255,
                                                              253,
                                                              253,
                                                              254),
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0)),
                                                          elevation: 15,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                    decoration: new BoxDecoration(
                                                                        border: new Border(
                                                                            left: BorderSide(
                                                                                color: /*Color.fromARGB(255, 138,216,35)*/ Color.fromARGB(255, 21, 95,
                                                                                    220),
                                                                                width:
                                                                                    6,
                                                                                style: BorderStyle
                                                                                    .solid))),
                                                                    // decoration: new ShapeDecoration(
                                                                    //     shape: new RoundedRectangleBorder(
                                                                    //         borderRadius: new BorderRadius.only(
                                                                    //             bottomLeft: Radius.circular(
                                                                    //                 15),
                                                                    //             topLeft: Radius.circular(
                                                                    //                 15)),
                                                                    //         side: new BorderSide(
                                                                    //             color: Colors
                                                                    //                 .green,
                                                                    //             width:
                                                                    //                 6.5,
                                                                    //             style: BorderStyle
                                                                    //                 .solid))),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                        children: <
                                                                            Widget>[
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              SizedBox(height: 25),
                                                                              Row(children: <Widget>[
                                                                                // SizedBox(
                                                                                //   width: 10,
                                                                                // ),
                                                                                //Image.asset("assets/icons/ethereum.png", fit: BoxFit.fill, alignment: Alignment.centerLeft, height: 63, width: 40),
                                                                                SizedBox(
                                                                                  width: 30,
                                                                                ),
                                                                                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                                                  Text("Ethereum (ETH)", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
                                                                                  Text("${(getToken.eTH.balance).toStringAsFixed(5)} ETH", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15))
                                                                                ])
                                                                              ]),
                                                                              SizedBox(height: 25),
                                                                            ],
                                                                          ),
                                                                          new Column(
                                                                              children: <Widget>[
                                                                                Container(padding: EdgeInsets.only(right: 20), alignment: Alignment.centerRight, child: Text("${(rates.firstWhere((x) => x.cur == currencies[selectedCur]).rate * c * getToken.eTH.balance).toStringAsFixed(2)} ${currencies[selectedCur]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                                                                              ])
                                                                        ]))
                                                              ]));
                                                    } else {
                                                      return new Card(
                                                          color: Color.fromARGB(
                                                              255,
                                                              253,
                                                              253,
                                                              254),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0)),
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          elevation: 8,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  decoration: new BoxDecoration(
                                                                      border: new Border(
                                                                          left: BorderSide(
                                                                              color: /*Colors.red*/ Color.fromARGB(255, 138, 216, 35),
                                                                              width: 6,
                                                                              style: BorderStyle.solid))),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                          height:
                                                                              25),
                                                                      Row(children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        Text(
                                                                            "${getToken.tokens[itemIndex - 1].tokenInfo.name} (${getToken.tokens[itemIndex - 1].tokenInfo.symbol})",
                                                                            style:
                                                                                new TextStyle(fontSize: 18, fontWeight: FontWeight.w300))
                                                                      ]),
                                                                      Row(children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                            width:
                                                                                30),
                                                                        Text(
                                                                            "${(getToken.tokens[itemIndex - 1].balance / math.pow(10, getToken.tokens[itemIndex - 1].tokenInfo.decimals)).toStringAsFixed(5)} ${getToken.tokens[itemIndex - 1].tokenInfo.symbol}",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w500, fontSize: 15))
                                                                      ]),
                                                                      SizedBox(
                                                                          height:
                                                                              25),
                                                                    ],
                                                                  ),
                                                                )
                                                              ]));
                                                    }
                                                  },
                                                ))
                                              ],
                                            ))
                                          : new Text(
                                              "Error: Something went wrong (EC2876)")
                                      : new CircularProgressIndicator())))
                    ]))
              ]),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, "/AddNewWallet");
              //   },
              //   child: Icon(Icons.add),
              //   tooltip: "New Wallet",
              //   //label: Text("Submit Entry"),
              // ),
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 4.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0),
                                child: IconButton(
                                  icon: Image.asset(
                                      'assets/icons/wallet-selected@2.png',
                                      scale: 2),
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //     context, '/Wallet');
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0),
                                child: IconButton(
                                  icon: Image.asset(
                                      'assets/icons/send-deselected@2.png',
                                      scale: 2),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/SendWallet');
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0),
                                child: IconButton(
                                  icon: Image.asset(
                                      'assets/icons/exchange-deselected@2.png',
                                      scale: 2),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/ExchangeWallet');
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0),
                                child: IconButton(
                                  icon: Image.asset(
                                      'assets/icons/settings-deselected@2.png',
                                      scale: 2),
                                  onPressed: () {
                                    showRoundedModalBottomSheet(
                                        color: Theme.of(context).canvasColor,
                                        dismissOnTap: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: Padding(
                                            padding: const EdgeInsets.all(32.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ModalDrawerHandle(
                                                    handleColor:
                                                        Colors.indigoAccent,
                                                  ),
                                                ),
                                                new Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: new Text(
                                                      'Absence Mobile',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Color.fromARGB(255, 21, 95, 220),
                                                      ),
                                                    )),
                                                Material(
                                                  child: ListTile(
                                                    leading:
                                                        Icon(OMIcons.settings),
                                                    title: Text("App Settings"),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      Navigator.pushNamed(
                                                          context, '/Settings');
                                                    },
                                                  ),
                                                ),
                                                Divider(
                                                  height: 0.0,
                                                  color: Colors.grey,
                                                ),
                                                ListTile(
                                                  leading: Icon(OMIcons.info),
                                                  title: Text("Absence Mobile"),
                                                  subtitle: Text("v0.1"),
                                                ),
                                              ],
                                            ),
                                          ));
                                        });
                                    //showModalBottomSheet();
                                    // Navigator.pushNamed(
                                    //     context, '/SettingsWallet');
                                  },
                                ),
                              ),
                            ])
                      ])));
        }));
  }

  Container _getBackground() {
    return new Container(
      decoration: BoxDecoration(color: Colors.blue),
      constraints: new BoxConstraints.expand(height: 300.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00736AB7), new Color(0xFF736AB7)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _buildCarousel(
      BuildContext context, int carouselIndex, int length, List mnemonics) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // SizedBox(
        //   height: 40,
        // ),
        // Text("My Wallets",
        //     style: TextStyle(
        //         fontSize: 30,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: "OpenSans")),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 180.0,
          child: PageView.builder(
            itemCount: length,
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.9),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(
                  context, carouselIndex, itemIndex, mnemonics);
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<http.Response> fetchPost(String address) {
    return http
        .get('http://api.ethplorer.io/getAddressInfo/$address?apiKey=freekey');
  }

  void getStuff(int index) {
    var seed1 = MnemonicUtils.generateMasterSeed(mnemonics[index], "");
    var rootSeed1 = getRootSeed(seed1);
    var priv1 = EthereumStandardHDWalletPath((rootSeed1));
    var creds1 = Credentials.fromPrivateKeyHex(priv1);
    rates.clear();
    print(rates);
    for (int i = 0; i < currencies.length; i++) {
      http
          .get(
              "https://api.coinmarketcap.com/v2/ticker/1027/?convert=${currencies[i]}")
          .then((result) {
        //print("https://api.coinmarketcap.com/v2/ticker/1027/?convert=${currencies[3]}");
        var a = json.decode(result.body);
        c = a["data"]["quotes"]["USD"]["price"];
        Rates b = new Rates(
            (a["data"]["quotes"][currencies[i]]["price"] /
                a["data"]["quotes"]["USD"]["price"]),
            currencies[i]);
        rates.add(b);
        // print(rates);
        //print(a["data"]["quotes"][currencies[selectedCur]]["price"]);
        //print("Hi");
      });
    }
    print(rates.toString());
    if (MainWalletStateState.currentWallet == null ||
        MainWalletStateState.currentWallet.address.hex != creds1.address.hex) {
      //print("Cool");
      MainWalletStateState.currentWallet = creds1;
      fetchPost(MainWalletStateState.currentWallet.address.toString())
          .then((reslt) {
        if (reslt.statusCode == 200) {
          setState(() {
            MainWalletStateState.getToken =
                GetTokens.fromJson(json.decode(reslt.body));
          });
          getToke = reslt.body;
          if (getToken.tokens != null) {
            print(getToken.tokens[0].tokenInfo.name);
          }
        } else {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: Text("Connection Error"),
          ));
        }
      });
    } else {
      //print("Not Cool");
    }
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex, List mnemonics) {
    var seed = MnemonicUtils.generateMasterSeed(mnemonics[itemIndex], "");
    var rootSeed = getRootSeed(seed);
    var priv = EthereumStandardHDWalletPath((rootSeed));
    var creds = Credentials.fromPrivateKeyHex(priv);
    var address = creds.address.hex.toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: new Material(
          elevation: 0,
          // decoration: BoxDecoration(
          //       gradient: new LinearGradient(
          //           colors: [Color(0xff7cd00f), Color(0xff7aca18)],
          //           begin: FractionalOffset.topLeft,
          //           end: FractionalOffset.bottomRight,
          //           stops: [0.0, 1.0],
          //           tileMode: TileMode.clamp),
          //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //     ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Color.fromARGB(255, 164, 221, 79),
          child: InkWell(
              onTap: () async {
                setState(() {
                  y = 1;
                });
                getStuff(itemIndex);
                await new Future.delayed(const Duration(seconds: 5))
                    .whenComplete(() {
                  setState(() {
                    y = 0;
                  });
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Row(children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Wallet ${itemIndex + 1}",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                    ]),
                    new InkWell(
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              new Text(
                                "${address.substring(0, 11)}...${address.substring(address.length - 11, address.length)}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              new Icon(
                                Icons.content_copy,
                                color: Colors.white,
                                size: 15,
                              )
                            ]),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: address));
                          // Scaffold.of(context).showSnackBar(new SnackBar(
                          //   content: Text("Copied"),
                          // ));
                          Fluttertoast.showToast(
                              msg: "Copied",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        }),
                    SizedBox(
                      height: 20,
                    )
                    // new QrImage(
                    //   data: address,
                    //   size: 120,
                    //   foregroundColor: Colors.white,
                    // ),
                  ],
                ),
              ))),
    );
  }
}
