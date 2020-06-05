import 'dart:convert';
import 'dart:io';

import 'package:citrixmobile/components/customButton.dart';
import 'package:citrixmobile/models/KeyValue.dart';
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddVm extends StatefulWidget {
  @override
  _AddVmState createState() => _AddVmState();
}

class _AddVmState extends State<AddVm> {
  TextEditingController name = new TextEditingController();
  TextEditingController ram = new TextEditingController();
  TextEditingController cpu = new TextEditingController();
  TextEditingController mac = new TextEditingController();
  TextEditingController network = new TextEditingController();
  TextEditingController iso = new TextEditingController();
  TextEditingController sr = new TextEditingController();
  TextEditingController template = new TextEditingController();
  bool _enabled = false;
  ProgressDialog pr;
  int selectedradio = 1;
  KeyValue selectedKeyValue1;
  KeyValue selectedKeyValue2;
  KeyValue selectedKeyValue3;
  KeyValue selectedKeyValue4;

  @override
  void initState() {
    selectedKeyValue1 = null;
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SuperState>(context);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    selectedKeyValue1 == null
        ? setState(() {
            selectedKeyValue1 = prov.template[0];
            selectedKeyValue2 = prov.iso[0];
            selectedKeyValue3 = prov.sr[0];
            selectedKeyValue4 = prov.net[0];
          })
        : null;
    return Scaffold(
      body: SingleChildScrollView(
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
                            Text("Création d'une VM",
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
                                hintText: "Nom de la machine",
                                icon: Icon(
                                  Icons.laptop,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: ram,
                              decoration: InputDecoration(
                                hintText: "RAM",
                                icon: Icon(
                                  Icons.memory,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: cpu,
                              decoration: InputDecoration(
                                hintText: "CPU",
                                icon: Icon(
                                  Icons.offline_bolt,
                                  size: 27,
                                  color: Color(0xFFF032f41),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Auto mac :"),
                                Radio(
                                  value: 1,
                                  groupValue: selectedradio,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedradio = 1;
                                      _enabled = false;
                                    });
                                  },
                                ),
                                Text("Manuelle mac : "),
                                Radio(
                                  value: 2,
                                  onChanged: (val) {
                                    print(val.toString());
                                    setState(() {
                                      selectedradio = 2;
                                      _enabled = true;
                                    });
                                  },
                                  groupValue: selectedradio,
                                ),
                              ],
                            ),
                            _enabled
                                ? TextField(
                                    controller: mac,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "mac",
                                      icon: Icon(
                                        Icons.alternate_email,
                                        size: 27,
                                        color: Color(0xFFF032f41),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 10),
                            Text(
                              "Template :",
                              style: TextStyle(
                                  color: Colors.red, letterSpacing: 2),
                            ),
                            new Center(
                              child: new DropdownButton<KeyValue>(
                                value: selectedKeyValue1,
                                onChanged: (KeyValue newValue) {
                                  setState(() {
                                    selectedKeyValue1 = newValue;
                                  });
                                  print(selectedKeyValue1);
                                },
                                items: prov.template.map((KeyValue keyvalue) {
                                  return new DropdownMenuItem<KeyValue>(
                                    value: keyvalue,
                                    child: new Text(
                                      keyvalue.value,
                                      style: new TextStyle(
                                          color: Colors.black, fontSize: 11),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "ISO :",
                              style: TextStyle(
                                  color: Colors.red, letterSpacing: 2),
                            ),
                            new Center(
                              child: new DropdownButton<KeyValue>(
                                value: selectedKeyValue2,
                                onChanged: (KeyValue newValue) {
                                  setState(() {
                                    selectedKeyValue2 = newValue;
                                  });
                                  print(selectedKeyValue2.value);
                                },
                                items: prov.iso.map((KeyValue keyvalue) {
                                  return new DropdownMenuItem<KeyValue>(
                                    value: keyvalue,
                                    child: new Text(
                                      keyvalue.value,
                                      style: new TextStyle(
                                          color: Colors.black, fontSize: 11),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Storage :",
                                style: TextStyle(
                                    color: Colors.red, letterSpacing: 2)),
                            DropdownButton<KeyValue>(
                              value: selectedKeyValue3,
                              onChanged: (KeyValue newValue) {
                                setState(() {
                                  selectedKeyValue3 = newValue;
                                });
                              },
                              items: prov.sr.map((KeyValue keyvalue) {
                                return new DropdownMenuItem<KeyValue>(
                                  value: keyvalue,
                                  child: new Text(
                                    keyvalue.value,
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        letterSpacing: 2),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),
                            Text("Réseau :",
                                style: TextStyle(
                                    color: Colors.red, letterSpacing: 2)),
                            DropdownButton<KeyValue>(
                              value: selectedKeyValue4,
                              onChanged: (KeyValue newValue) {
                                setState(() {
                                  selectedKeyValue4 = newValue;
                                });
                              },
                              items: prov.net.map((KeyValue keyvalue) {
                                return new DropdownMenuItem<KeyValue>(
                                  value: keyvalue,
                                  child: new Text(
                                    keyvalue.value,
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        letterSpacing: 2),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 40),
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
                              label: "Ajouter",
                              fontColor: Colors.white,
                              background: Color(0xFFF1f94aa),
                              borderColor: Color(0xFFF1a7a8c),
                              onTap: () async {
                                try {
                                  pr.style(
                                      message: 'Création...',
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
                                  var url = prov.ip + "/api/vm/addVm";
                                  print(url);
                                  Map<String, String> headers = {
                                    'Content-type': 'application/json',
                                    'Authorization': 'Bearer ${prov.token}'
                                  };
                                  print(
                                      '{"name": "${name.text}","uuidTemplate":"${selectedKeyValue1.key}","uuidNetwork": "${selectedKeyValue4.key}","uuidStorage": "${selectedKeyValue3.key}","uuidiso": "${selectedKeyValue2.key}","ram": ${ram.text},"cpu": ${cpu.text},"mac": ""}');
                                  var response = await http.post(url,
                                      body:
                                          '{"name": "${name.text}","uuidTemplate":"${selectedKeyValue1.key}","uuidNetwork": "${selectedKeyValue4.key}","uuidStorage": "${selectedKeyValue3.key}","uuidiso": "${selectedKeyValue2.key}","ram": ${ram.text},"cpu": ${cpu.text},"mac": "${mac.text}"}',
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
                                        "Err de creation de VM ");
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
                                    title: Text("Erreur"),
                                    content: Text("erreur de creation du VM "),
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
