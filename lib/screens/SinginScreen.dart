import 'dart:convert';
import 'dart:io';

import 'package:citrixmobile/components/customButton.dart';
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class SinginScreen extends StatefulWidget {
  @override
  _SinginScreenState createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  TextEditingController ip = new TextEditingController();
  TextEditingController user = new TextEditingController();
  TextEditingController password = new TextEditingController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SuperState>(context);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login.jpg"),
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: Colors.white, size: 32),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                        height: MediaQuery.of(context).size.height * 0.70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("S'inscrire",
                                  style: TextStyle(
                                      color: Color(0xFFF032f42),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text("XenServer informations:",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 25)),
                              SizedBox(height: 10),
                              TextField(
                                controller: ip,
                                decoration: InputDecoration(
                                  hintText: "IP",
                                  icon: Icon(
                                    Icons.alternate_email,
                                    size: 27,
                                    color: Color(0xFFF032f41),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: user,
                                decoration: InputDecoration(
                                  hintText: "Utilisateur",
                                  icon: Icon(
                                    Icons.supervised_user_circle,
                                    size: 27,
                                    color: Color(0xFFF032f41),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Mot de passe",
                                  icon: Icon(
                                    Icons.https,
                                    size: 27,
                                    color: Color(0xFFF032f41),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
//                          DropdownButton<String>(
//                            items: <String>['Foo', 'Bar'].map((String value) {
//                              return new DropdownMenuItem<String>(
//                                value: value,
//                                child: new Text(value),
//                              );
//                            }).toList(),
//                            onChanged: (_) {},
//                          ),
                              CustomButton(
                                label: "S'inscrire",
                                fontColor: Colors.white,
                                background: Color(0xFFF1f94aa),
                                borderColor: Color(0xFFF1a7a8c),
                                onTap: () async {
                                  if (ip.text == "" ||
                                      user.text == "" ||
                                      password.text == "") {
                                    final snackBar = SnackBar(
                                        content: Text(
                                            'Ooops Remplie tous les champs!'));
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  } else {
                                    try {
                                      pr.style(
                                          message: 'Création du compte...',
                                          borderRadius: 10.0,
                                          backgroundColor: Colors.white,
                                          progressWidget:
                                              CircularProgressIndicator(),
                                          elevation: 10.0,
                                          insetAnimCurve: Curves.easeInOut,
                                          progress: 0.0,
                                          maxProgress: 100.0,
                                          progressTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400),
                                          messageTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.w600));
                                      await pr.show();
                                      var url =
                                          prov.ip + "/api/Utilisateur/ajouter";
                                      print(url);
                                      Map<String, String> headers = {
                                        'Content-type': 'application/json',
                                      };
                                      var response = await http.post(url,
                                          body:
                                              '{"username": "${user.text}","ip":"${ip.text}","password": "${password.text}"}',
                                          headers: headers);
                                      print(
                                          'Respon Navigator.pop(context);se status: ${response.statusCode}');
                                      print('Response body: ${response.body}');
                                      if (response.statusCode == 200) {
                                        prov.nameChanger(myname: user.text);
                                        await pr.hide();
                                        Navigator.pop(context);
                                      } else {
                                        await pr.hide();
                                        throw new Exception(
                                            "Err de creation de compte ");
                                      }
                                    } catch (ex) {
                                      await pr.hide();
                                      print(
                                          "*************err************** ${ex}");
                                      Widget okButton = FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                      // set up the AlertDialog
                                      AlertDialog alert = AlertDialog(
                                        title: Text("Erreur"),
                                        content: Text(
                                            "Erreur lors de la création du compte"),
                                        actions: [
                                          okButton,
                                        ],
                                      );

                                      // show the dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
