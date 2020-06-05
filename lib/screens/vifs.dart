import 'package:citrixmobile/components/customButton.dart';
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Vifs extends StatefulWidget {
  @override
  _VifsState createState() => _VifsState();
}

class _VifsState extends State<Vifs> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SuperState>(context);
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    Map data = ModalRoute.of(context).settings.arguments;
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < data['vifs'].length; i++) {
      list.add(Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              decoration: new BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(data['vifs'][i]['Network_name'],
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text("MAC : " + data['vifs'][i]['mac'],
                            style: TextStyle(fontSize: 15, color: Colors.white))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomButton(
            label: "Supprimer",
            fontColor: Colors.white,
            background: Color(0xFFF1f94aa),
            borderColor: Color(0xFFF1a7a8c),
            onTap: () async {
              try {
                pr.style(
                    message: 'Supprression ...',
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
                    "/api/vm/removeVIS/${data['vifs'][i]['uuid']}/${data['uuid']}";
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
      ));
    }
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: SingleChildScrollView(child: Column(children: list)))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/vif', arguments: {
            'machine': data["uuid"],
          });
        },
      ),
    );
  }
}
