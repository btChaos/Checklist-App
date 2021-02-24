
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/screens/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Excel extends StatefulWidget {
  @override
  _ExcelState createState() => _ExcelState();
}

class _ExcelState extends State<Excel> {

  

 @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  } //



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
            'https://docs.google.com/spreadsheets/d/1EBBlfg49U0eDAJvGrITbKiGq_Cbgxd6l4KKZCg_Slb8/edit#gid=761378430',
             
  ),
  );
}