import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:citrixmobile/provider/Super.dart';

class Log extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}
class _LogState extends State<Log> {
  ProgressDialog  pr;
  int i=0;
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<SuperState>(context);
    if(i++==0){
    prov.getLog();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Log de votre compte"),
      ),
      body: ListView.builder(itemCount:prov.log.length,
        itemBuilder: (context,index){
          return Card(
            child:ListTile(
              onTap: (){
              },
              title: Text(prov.log[index]['description']),
              subtitle:Text(prov.log[index]['date']) ,
            ),
          );
        },
      ),
    );
  }
}
