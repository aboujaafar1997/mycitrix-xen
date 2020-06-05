import 'dart:convert';
import 'dart:io';

import 'package:citrixmobile/components/customButton.dart';
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddNetwork extends StatefulWidget {
  @override
  _AddNetworkState createState() => _AddNetworkState();
}

class _AddNetworkState extends State<AddNetwork> {
  TextEditingController name = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  TextEditingController mtu = new TextEditingController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SuperState>(context);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/net.jpg"),
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
                            Text("Création d'un réseau",
                                style: TextStyle(
                                    color: Color(0xFFF032f42),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 40),
                            Text("Remplir les champs:",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 25)),
                            SizedBox(height: 10),
                            TextField(
                              controller: name,
                              decoration: InputDecoration(
                                hintText: "Nom",
                                icon: Icon(
                                  Icons.blur_on,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: desc,
                              decoration: InputDecoration(
                                hintText: "Description",
                                icon: Icon(
                                  Icons.format_paint,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: mtu,
                              decoration: InputDecoration(
                                hintText: "MTU",
                                icon: Icon(
                                  Icons.av_timer,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 40),
                            CustomButton(
                              label: "Ajouter",
                              fontColor: Colors.white,
                              background: Color(0xFFF1f94aa),
                              borderColor: Color(0xFFF1a7a8c),
                              onTap: () async {
                                try {
                                  pr.style(
                                      message: 'Création du reseau...',
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
                                  var url = prov.ip + "/api/network/add";
                                  print(url);
                                  Map<String, String> headers = {
                                    'Content-type': 'application/json',
                                    'Authorization': 'Bearer ${prov.token}'
                                  };
                                  var response = await http.post(url,
                                      body:
                                          '{"nameLabel": "${name.text}","nameDescription":"${desc.text}","MTU": "${mtu.text}"}',
                                      headers: headers);
                                  print(
                                      'Respon Navigator.pop(context);se status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  if (response.statusCode == 200) {
                                    await pr.hide();
                                    prov.tokenChanger(
                                        context: context, mytoken: "");
                                    Navigator.pop(context);
                                  } else {
                                    await pr.hide();
                                    throw new Exception(
                                        "Err de creation de Network ");
                                  }
                                } catch (ex) {
                                  await pr.hide();
                                  print("*************err************** ${ex}");
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Err"),
                                    content:
                                        Text("ereur de création du réseau "),
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
    );
  }
}
