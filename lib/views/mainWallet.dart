import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MainWalletState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainWalletState();
  }
}

class _MainWalletState extends State<MainWalletState> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 21, 95, 220),
            accentColor: Color.fromARGB(255, 21, 95, 220),
            hintColor: Colors.white),
        home: new Builder(builder: (ctx) {
          return new Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/AddNewWallet");
                },
                child: Icon(Icons.add),
                tooltip: "New Wallet",
                //label: Text("Submit Entry"),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
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
                              padding: const EdgeInsets.only(left: 16.0),
                              child: IconButton(
                                icon: Icon(OMIcons.callReceived),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/ReceiveWallet');
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: IconButton(
                                icon: Icon(OMIcons.send),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/SendWallet');
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 40.0),
                                child: IconButton(
                                  icon: Icon(OMIcons.swapHoriz),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/ExchangeWallet');
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: IconButton(
                                  icon: Icon(OMIcons.settings),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/SettingsWallet');
                                  },
                                ),
                              ),
                            ])
                      ])));
        }));
  }
}
/*bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    icon: Icon(OMIcons.more),
                    onPressed: () {
                      showRoundedModalBottomSheet(
                        context: context,
                        color: Theme.of(context).canvasColor,
                        dismissOnTap: false,
                        builder: (builder) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ModalDrawerHandle(
                                  handleColor: Colors.indigoAccent,
                                ),
                              ),
                              ListTile(
                                leading: Icon(OMIcons.accountCircle),
                                title: Text(currentUser.displayName),
                                subtitle: userSubtitle,
                                trailing: FlatButton(
                                  child: Text("Log Out"),
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushNamedAndRemoveUntil('/',(Route<dynamic> route) => false);
                                  },
                                ),
                              ),
                              Divider(
                                height: 0.0,
                                color: Colors.grey,
                              ),
                              Material(
                                child: ListTile(
                                  title: Text("My Submissions"),
                                  leading:
                                      Icon(GroovinMaterialIcons.upload_multiple),
                                  onTap: () {},
                                ),
                              ),
                              Material(
                                child: ListTile(
                                  leading: Icon(OMIcons.settings),
                                  title: Text("App Settings"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/Settings');
                                  },
                                ),
                              ),
                              Divider(
                                height: 0.0,
                                color: Colors.grey,
                              ),
                              ListTile(
                                leading: Icon(OMIcons.info),
                                title: Text("Flutter Community Challenges"),
                                subtitle: Text(_packageInfo.version),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                */
