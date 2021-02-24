import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/screens/epi.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:test1/screens/home.dart';

//necessário ser um statefulwidget para usar composição híbrida
class Pesado extends StatefulWidget {
  const Pesado({Key key}) : super(key: key);
  @override
  PesadoState createState() => PesadoState();
}

class PesadoState extends State<Pesado> {
  //State<> sempre colocar o nome da classe principal entre "<>"
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  } //composição híbrida

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Checklists'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          }, //navegação para home page pelo back button
        ),
      ),
      body: Container(
        child: _buildWebView1(context),
      ),
    );
  }
}

Widget _buildWebView1(BuildContext context) {
  return Scaffold(
    body: WebView(
        javascriptMode:
            JavascriptMode.unrestricted, //nunca esquecer javascriptMode
        initialUrl:
            'https://docs.google.com/forms/d/e/1FAIpQLSc56PI6mjW-oP1_tvJZYLbYY9e0pry6-FrrW61R66awN4ihPg/viewform?usp=sf_link'),
             floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_forward, color: Colors.white),
              backgroundColor: Colors.red,
              onPressed: () {Navigator.push( context, MaterialPageRoute(builder: (context)=>Epi())
            );}  ),
  );
} //webview do google
