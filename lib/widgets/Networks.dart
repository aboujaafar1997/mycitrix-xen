import 'dart:convert';

import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
class Networks extends StatefulWidget {
  @override
  _NetworksState createState() => _NetworksState();
}

class _NetworksState extends State<Networks> {
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<SuperState>(context);

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return SafeArea(
      child: Container(
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: prov.net.length,
          itemBuilder: (context, index){
            var machines = prov.net[index];
            return beacheItem(machines,context,prov.ip,prov.token,index,prov);
            return beacheItem(machines,context,prov.ip,prov.token,index,prov);
          },
        ),
      ),
    );
  }

  Widget beacheItem(var machines,BuildContext context,String ip,String token,int index,var prov){
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF082938)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                width: 220,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/net.png'),
                        fit: BoxFit.cover
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(machines.value,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        )),
                    SizedBox(height: 5),


                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.brightness_high,color: Colors.white),
                      ),
                        IconButton(
                         icon: Icon(Icons.delete,color: Colors.white),
                          onPressed: () async {
                            Widget okButton = FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            try {
                              print(machines.key);
                              pr.style(
                                  message: 'Suppression...',
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
                              var url = ip+"/api/network/delete/"+machines.key;
                              print(url);
                              Map<String,String> headers = {
                                'Content-type' : 'application/json',
                                'Authorization':  'Bearer ${token}'

                              };
                              var response = await http.post(url,headers: headers);
                              print('Response status: ${response.statusCode}');
                              if(response.statusCode==200){
                                await pr.hide();
                                prov.tokenChanger(context:context,mytoken:"");
                                AlertDialog alert = AlertDialog(
                                  title: Text("Message :"),
                                  content: Text("Bien supprimer"),
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
                              }else{
                                throw new Exception("Err de Redémarrage ");
                              }
                            }catch(ex){
                              await pr.hide();
                              print("*************err************** ${ex}");
                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Erreur!"),
                                content: Text("ereur de suppression"),
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  Widget beacheItemIcon(IconData iconData, String text){
    return Row(
      children: <Widget>[
        Icon(iconData, color: Colors.white),
        SizedBox(width: 2),
        Text(text, style: TextStyle(color: Colors.white))
      ],
    );
  }
}