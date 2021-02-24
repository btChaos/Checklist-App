import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {

    
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

    final formKey = GlobalKey<FormState>();
    TextEditingController user = new TextEditingController();
    TextEditingController senha = new TextEditingController();

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
        alignment: Alignment.bottomCenter,
        child:Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           Form( key: formKey,
             
             child: Column(
            children: [ TextFormField(
              controller: user,
              decoration: textFieldInputDecoration("Usuário"),
            ),
            TextFormField(
              controller: senha,
              obscureText: true,
              decoration: textFieldInputDecoration("Senha"),
            ),
             ] )),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20,),
                decoration: BoxDecoration(
                  
                  gradient: LinearGradient(
                    colors: [
                        const Color(0xFFEF5350),
                        const Color(0xFFE57373) 
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Login", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 16,),
            SizedBox(height: 16,),
            SizedBox(height: 16,),
          ],
          ),
          ),
          ),
          );
  }
}

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


InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
                hintText: hintText,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE57373)), //0xFFE57373
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE57373))
                ),
                
                );
}


