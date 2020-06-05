import 'dart:convert';
import 'package:citrixmobile/provider/Super.dart';
import 'package:citrixmobile/components/customButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ProgressDialog  pr;
  TextEditingController user = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<SuperState>(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return Scaffold(
      body: Builder(
        builder: (context) =>SingleChildScrollView(
          child: Container(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/citrix.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter
                )
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 50),
                      height: MediaQuery.of(context).size.height * 0.70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Bienvenue",style: TextStyle(
                            color: Color(0xFFF032f42),
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          )),
                          Text("Connectez-vous!",style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25
                          )),
                          SizedBox(height: 40),
                          TextField(
                            controller: user,
                            decoration: InputDecoration(
                              hintText: "Utilisateur",
                              icon: Icon(Icons.supervised_user_circle, size: 27,color: Color(0xFFF032f41),),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Mot de passe",
                              icon: Icon(Icons.https, size: 27,color: Color(0xFFF032f41),),
                            ),
                          ),
                          SizedBox(height: 40),
                          CustomButton(
                            onTap: () async {
                              if(user.text==""|| password.text==""){
                                final snackBar = SnackBar(content: Text('Ooops Remplie tous les champs!'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                              else{
                              try {
                                pr.style(
                                    message: 'Authentification ...',
                                    borderRadius: 10.0,
                                    backgroundColor: Colors.white,
                                    progressWidget: CircularProgressIndicator(),
                                    elevation: 10.0,
                                    insetAnimCurve: Curves.easeInOut,
                                    progress: 0.0,
                                    maxProgress: 100.0,
                                    progressTextStyle: TextStyle(
                                        color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                                    messageTextStyle: TextStyle(
                                        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
                                );
                                await pr.show();
                                var url = prov.ip+"/api/login";
                                print(url);
                                Map<String,String> headers = {
                                  'Content-type' : 'application/json',
                                };
                                var response = await http.post(url, body: '{"username": "${user.text}", "password": "${password.text}"}',headers: headers);
                                print('Respon Navigator.pop(context);se status: ${response.statusCode}');
                                print('Response body: ${response.body}');
                                if(response.statusCode==200){
                                  Map<String, dynamic> data = json.decode(response.body);
                                  await pr.hide();

                                  prov.nameChanger(myname: user.text);
                                  prov.tokenChanger(mytoken:data['token'],context: context);
                                  Navigator.pushReplacementNamed(context, '/machines');
                                }else{
                                  await pr.hide();
                                  throw new Exception("Err de login");
                                }
                              }catch(ex){
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
                                  title: Text("Erreur!"),
                                  content: Text("Erreur d'authentification "),
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
                            label: "Authentifier",
                            fontColor: Colors.white,
                            background: Color(0xFFF1f94aa),
                            borderColor: Color(0xFFF1a7a8c),
                          )
                        ],
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