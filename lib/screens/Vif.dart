import 'package:citrixmobile/components/customButton.dart';
import 'package:citrixmobile/models/KeyValue.dart';
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class Vif extends StatefulWidget {
  @override
  _VifState createState() => _VifState();
}

class _VifState extends State<Vif> {
  TextEditingController mac = new TextEditingController();
  TextEditingController network = new TextEditingController();
  bool _enabled = false;
  ProgressDialog pr;
  int selectedradio = 1;
  KeyValue selectedKeyValue1;

  @override
  void initState() {
    selectedKeyValue1 = null;
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    final prov = Provider.of<SuperState>(context);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    selectedKeyValue1 == null
        ? setState(() {
            selectedKeyValue1 = prov.net[0];
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
                            Text("Création de VIF",
                                style: TextStyle(
                                    color: Color(0xFFF032f42),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 40),
                            Text("Remplir les champs:",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 25)),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Auto MAC :"),
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
                                Text("Manuelle MAC : "),
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
                                    decoration: InputDecoration(
                                      hintText: "MAC",
                                      icon: Icon(
                                        Icons.alternate_email,
                                        size: 27,
                                        color: Color(0xFFF032f41),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                            Text("Réseau :",
                                style: TextStyle(
                                    color: Colors.red, letterSpacing: 2)),
                            DropdownButton<KeyValue>(
                              value: selectedKeyValue1,
                              onChanged: (KeyValue newValue) {
                                setState(() {
                                  selectedKeyValue1 = newValue;
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
                                      message: 'Création du VIF...',
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
                                  var url = prov.ip +
                                      "/api/vm/addVif/${data['machine']}/${selectedKeyValue1.key}/${mac.text == "" ? "non" : mac.text}";
                                  print(url);
                                  Map<String, String> headers = {
                                    'Content-type': 'application/json',
                                    'Authorization': 'Bearer ${prov.token}'
                                  };
                                  var response =
                                      await http.post(url, headers: headers);
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
                                        "Ereur de Création de VIF ");
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
                                    content: Text(
                                        "Ereur de Création du VIF connexion échoué "),
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
