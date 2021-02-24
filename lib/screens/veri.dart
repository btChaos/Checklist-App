import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/screens/home.dart';

class Veri extends StatefulWidget {
  @override
  _VeriState createState() => _VeriState();
}

class _VeriState extends State<Veri> {
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
        
      )

    );
  }
}