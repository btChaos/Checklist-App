import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/screens/pesado.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:test1/screens/home.dart';

//necessário ser statefulwidget para usar composição híbrida
class Leve extends StatefulWidget {
  const Leve({Key key}) : super(key: key);
  @override
  LeveState createState() => LeveState();
}

class LeveState extends State<Leve> {
  //State<> sempre colocar nome da classe principal entre "<>"
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
          }, // navegação para home page pelo back button
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
            'https://docs.google.com/forms/d/e/1FAIpQLScpBVCJiqzSFfuiyMlhyKnHqrdwtgNN38OsLQH5MxrSBCePRg/viewform'),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_forward, color: Colors.white),
              backgroundColor: Colors.red,
              onPressed: () {Navigator.push( context, MaterialPageRoute(builder: (context)=>Pesado())
            );}  ),
  );
} //webview do google docs
