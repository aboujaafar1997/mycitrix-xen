
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
class Machines extends StatefulWidget {
  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
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
          itemCount: prov.machines.length,
          itemBuilder: (context, index){
            var machines = prov.machines[index];
            return beacheItem(machines,context,prov.ip,prov.token,index,prov.stateChanger);
          },
        ),
      ),
    );
  }

  Widget beacheItem(var machines,BuildContext context,String ip,String token,int index,final state){

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/info', arguments: {
          'machine': machines,
        });
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
                        image: machines['nameVm'].toString().toLowerCase().startsWith("win")?AssetImage('assets/images/windows.png'):AssetImage('assets/images/ubunto.png'),
                        fit: BoxFit.cover
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(machines['nameVm'],
                        style: TextStyle(
                            color: Colors.white,
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
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Statut : "+machines['statePower'], style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  )),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.sync,color: Colors.white),
                        onPressed: () async {
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          try {
                            state(index:index,state:"Demarage en cours");
                            pr.style(
                                message: 'Demarage...',
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
                            var url = ip+"/api/vm/reboot/"+machines['uuid'];
                            print(url);
                            Map<String,String> headers = {
                              'Content-type' : 'application/json',
                              'Authorization':  'Bearer ${token}'

                            };
                            var response = await http.post(url,headers: headers);
                            print('Respon Navigator.pop(context);se status: ${response.statusCode}');
                            if(response.statusCode==200){
                              state(index:index,state:"Redémarrage");

                              await pr.hide();
                              AlertDialog alert = AlertDialog(
                                title: Text("Message :"),
                                content: Text("Redémarrage avec succès"),
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
                            state(index:index,state:"Err de Redémarrage ");

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Erreur!"),
                              content: Text("ereur de Redémarrage"),
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
                      IconButton(
                        icon: Icon(Icons.play_arrow,color: Colors.white),
                        onPressed: () async {
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          try {
                            state(index:index,state:"Démarrage en cours");
                            pr.style(
                                message: 'Démarrage...',
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
                            var url = ip+"/api/vm/start/"+machines['uuid'];
                            print(url);
                            Map<String,String> headers = {
                              'Content-type' : 'application/json',
                              'Authorization':  'Bearer ${token}'

                            };
                            var response = await http.post(url,headers: headers);
                            print('Respon Navigator.pop(context);se status: ${response.statusCode}');
                            if(response.statusCode==200){
                              state(index:index,state:"Démarrage");

                              await pr.hide();
                              AlertDialog alert = AlertDialog(
                                title: Text("Message :"),
                                content: Text("Démarrage avec succès"),
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
                              throw new Exception("Err de login to server");
                            }
                          }catch(ex){
                            await pr.hide();
                            print("*************err************** ${ex}");
                            state(index:index,state:"Err de Démarrage ");

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Erreur!"),
                              content: Text("Ereur de Démarrage"),
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
                      IconButton(

                        icon: Icon(Icons.stop,color: Colors.white),
                        onPressed: () async {
                          Widget okButton = FlatButton(
                           child: Text("OK"),
                            onPressed: () {
                            Navigator.pop(context);
                           },
                          );
                          try {
                            state(index:index,state:"Arrêter...");


                          pr.style(
                          message: 'Arrêter...',
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
                          var url = ip+"/api/vm/shutdown/"+machines['uuid'];
                          print(url);
                          Map<String,String> headers = {
                          'Content-type' : 'application/json',
                          'Authorization':  'Bearer ${token}'

                          };
                          var response = await http.post(url,headers: headers);
                          print('Respon Navigator.pop(context);se status: ${response.statusCode}');
                          if(response.statusCode==200){
                            state(index:index,state:"Arrêter");
                            await pr.hide();
                          AlertDialog alert = AlertDialog(
                            title: Text("Message :"),
                            content: Text("Arrêt avec succès"),
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
                          throw new Exception("Err de login to server");
                          }
                          }catch(ex){
                          await pr.hide();
                          print("*************err************** ${ex}");
                          state(index:index,state:"Err de l'Arrêter");

                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Erreur!"),
                            content: Text("opps ereur!"),
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
                      IconButton(
                        icon: Icon(Icons.brightness_low,color: Colors.white),
                        onPressed: (){
                          Navigator.pushNamed(context, '/info', arguments: {
                            'machine': machines,
                          });                        },
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