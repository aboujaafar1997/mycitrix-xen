import 'package:citrixmobile/components/customButton.dart';
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SuperState>(context);
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(data['machine']['nameVm'],
                        style: TextStyle(fontSize: 40, letterSpacing: 2.0))),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: new BoxDecoration(
                      color: Colors.green,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Ram : " + data['machine']['ram'].toString() + " mo",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: new BoxDecoration(
                      color: Colors.green,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "CPU : " + data['machine']['nbreCPU'].toString() + "",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: new BoxDecoration(
                      color: Colors.green,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "LastReboot : " +
                            data['machine']['lastReboot'].toString() +
                            "",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: new BoxDecoration(
                      color: Colors.green,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "startDelay : " +
                            data['machine']['startDelay'].toString() +
                            " s",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.green,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                      )),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Disk : 11580 mo",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  label: "Gestion des Vifs",
                  fontColor: Colors.white,
                  background: Color(0xFFF1f94aa),
                  borderColor: Color(0xFFF1a7a8c),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/vifs',
                        arguments: {
                          'vifs': data['machine']['vifs'],
                          'uuid': data['machine']['uuid']
                        });
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  label: "Supprimer la machine",
                  fontColor: Colors.white,
                  background: Color(0xFFF1f94aa),
                  borderColor: Color(0xFFF1a7a8c),
                  onTap: () async {
                    try {
                      pr.style(
                          message: 'Supprission ...',
                          borderRadius: 10.0,
                          backgroundColor: Colors.white,
                          progressWidget: CircularProgressIndicator(),
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
                          "/api/vm/deletevm/${data['machine']['uuid']}";
                      print(url);
                      Map<String, String> headers = {
                        'Content-type': 'application/json',
                        'Authorization': 'Bearer ${prov.token}'
                      };
                      var response = await http.post(url, headers: headers);
                      print(
                          'Respon Navigator.pop(context);se status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      if (response.statusCode == 200) {
                        await pr.hide();

                        prov.tokenChanger(mytoken: "", context: context);
                        Navigator.pushReplacementNamed(context, '/machines');
                      } else {
                        await pr.hide();
                        throw new Exception("Err ");
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
                        content: Text("erreur  "),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
