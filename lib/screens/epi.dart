import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:test1/screens/home.dart';

//necessário ser um statefulwidget para usar composição híbrida
class Epi extends StatefulWidget {
  const Epi({Key key}) : super(key: key);
  @override
  EpiState createState() => EpiState();
}

class EpiState extends State<Epi> {
  //State<> sempre colocar nome da classe entre "<>"
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  } //composição híbrida sempre colocar

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
        child: _buildWebView(context),
      ),
    );
  }
}

Widget _buildWebView(BuildContext context) {
  return Scaffold(
    body: WebView(
        javascriptMode:
            JavascriptMode.unrestricted, //nunca esquecer do javascriptMode
        initialUrl:
            'https://docs.google.com/forms/d/e/1FAIpQLSd3l5B-SV6TmMroeOd_o8q09qhHEaeIkIW0nD7RLRyWiI9qeQ/viewform?usp=sf_link',
            ),
              floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_forward, color: Colors.white),
              backgroundColor: Colors.red,
              onPressed: () {Navigator.push( context, MaterialPageRoute(builder: (context)=>MyHomePage())
            );}  ),
  );
} //webview do google docs
