import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test1/screens/leve.dart';
import 'package:test1/screens/pesado.dart';
import 'package:test1/screens/epi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_mac/get_mac.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionGroup {
  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _macAddress = "Unknown";
  @override
  void initState() {
    super.initState();
    initPlatformState();
    initPermission();
  }

  Future<void> initPlatformState() async {
    String macAddress;
    try {
      macAddress = await GetMac.macAddress;
    } on PlatformException {
      macAddress = "Falhei";
    }

    if (!mounted) return;
    setState(() {
      _macAddress = macAddress;
    });
  }

  var locationMessage = "";
  initPermission() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      locationMessage = "$position.longitude,$position.altitude";
    });
    final ph = PermissionHandler();
    final requested = await ph.requestPermissions(
        [PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]);

    final alwaysGranted =
        requested[PermissionGroup.locationAlways] == PermissionStatus.granted;
    final whenInUseGranted = requested[PermissionGroup.locationWhenInUse] ==
        PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Checklists'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(CupertinoIcons.info_circle),
          onPressed: () {
            alertDialog(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(CupertinoIcons.car_detailed),
                iconSize: 70,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 650),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation,
                              Widget child) {
                            return SlideTransition(
                                position: Tween<Offset>(
                                        begin: const Offset(-1.0, 0.0),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset.zero,
                                    end: const Offset(-1.0, 0.0),
                                  ).animate(secAnimation),
                                  child: child,
                                ));
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation) {
                            return Leve();
                          }));
                },
                color: Colors.black,
              ),
              Text("Veículos Leves",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 60),
              IconButton(
                //icone clicável
                icon: Icon(Icons.local_shipping_sharp),
                iconSize: 70,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 650),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation,
                              Widget child) {
                            return SlideTransition(
                                position: Tween<Offset>(
                                        begin: const Offset(-1.0, 0.0),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset.zero,
                                    end: const Offset(-1.0, 0.0),
                                  ).animate(secAnimation),
                                  child: child,
                                ));
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation) {
                            return Pesado();
                          }));
                },
                color: Colors.black,
              ),
              Text("Veículos Pesados",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 60),
              IconButton(
                icon: Icon(Icons.engineering_sharp),
                iconSize: 75,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          //define tempo da duração da animação
                          transitionDuration: Duration(milliseconds: 650),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation,
                              Widget child) {
//retorna animação escolhida
                            return SlideTransition(
                                position: Tween<Offset>(
                                        begin: const Offset(-1.0, 0.0),
                                        end: Offset.zero)
                                    .animate(animation),
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset.zero,
                                    end: const Offset(-1.0, 0.0),
                                  ).animate(secAnimation),
                                  child: child,
                                ));
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation) {
                            return Epi(); //pagina de destino
                          }));
                },
                color: Colors.black,
              ),
              Text("EPI", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      floatingActionButton: buildSpeedDial(),
    );
  }
}

PermissionHandler() {}

//Função que mostra o alerta
alertDialog(BuildContext context) {
  // botão de ok
  Widget ok = FlatButton(
    child: Text("Fechar"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Sobre"),
        content: Text(
            "\nVersão: 1.1.6 \nDesenvolvimento: Bruno Teixeira \nPara quaisquer dúvidas, procurar o TI."),
        actions: [
          ok,
        ],
        elevation: 5,
      );
    },
  );
}

//função do link do whatsapp
_launchURL() async {
  const url = 'https://docs.google.com/spreadsheets/d/1EBBlfg49U0eDAJvGrITbKiGq_Cbgxd6l4KKZCg_Slb8/edit#gid=761378430';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL1() async {
  const url = 'https://docs.google.com/spreadsheets/d/1Ejbiyp2nNkJjVjeOKkTvlzmgOtsJ2PwLUmaPzyqVh-8/edit?usp=sharing';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL2() async {
  const url = 'https://docs.google.com/spreadsheets/d/1Yj1QLiFYhhnXNoRfkvmzHCAxq1-R3-yrRMXxKNfUJGY/edit?usp=sharing';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//https://wa.me/5521981413983?text=Oi

SpeedDial buildSpeedDial() {
  return SpeedDial(
    /// both default to 16
    marginEnd: 18,
    marginBottom: 20,
    // animatedIcon: AnimatedIcons.menu_close,
    // animatedIconTheme: IconThemeData(size: 22.0),
    /// This is ignored if animatedIcon is non null
    icon: CupertinoIcons.check_mark,
    activeIcon: Icons.remove,
    // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),

    /// The label of the main button.
    // label: Text("Open Speed Dial"),
    /// The active label of the main button, Defaults to label if not specified.
    // activeLabel: Text("Close Speed Dial"),
    /// Transition Builder between label and activeLabel, defaults to FadeTransition.
    // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
    /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
    buttonSize: 56.0,
    visible: true,

    /// If true user is forced to close dial manually
    /// by tapping main button and overlay is not rendered.
    closeManually: false,
    curve: Curves.bounceIn,
    overlayColor: Colors.white,
    overlayOpacity: 0.5,
    onOpen: () => print('OPENING DIAL'),
    onClose: () => print('DIAL CLOSED'),
    tooltip: 'Acesso as respostas dos formulários',
    heroTag: 'speed-dial-hero-tag',
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    elevation: 8.0,
    shape: CircleBorder(),
    // orientation: SpeedDialOrientation.Up,
    // childMarginBottom: 2,
    // childMarginTop: 2,
    children: [
      SpeedDialChild(
        child: Icon(CupertinoIcons.car_detailed, color: Colors.black),
        backgroundColor: Colors.white,
        label: 'Veículos Leves',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => _launchURL(),
      ),
      SpeedDialChild(
        child: Icon(Icons.local_shipping_sharp, color: Colors.black),
        backgroundColor: Colors.white,
        label: 'Veículos Pesados',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => _launchURL1(),
      ),
      SpeedDialChild(
        child: Icon(Icons.engineering_sharp, color: Colors.black),
        backgroundColor: Colors.white,
        label: 'EPI',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => _launchURL2(),
      ),
    ],
  );
}
