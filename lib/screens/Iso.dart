import 'dart:convert';

import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class Iso extends StatefulWidget {
  @override
  _IsoState createState() => _IsoState();
}

class _IsoState extends State<Iso> {
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SuperState>(context);

    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    return SafeArea(
      child: Container(
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: prov.iso.length,
          itemBuilder: (context, index) {
            var machines = prov.iso[index];
            return beacheItem(machines, context, prov.ip, prov.token, index,
                prov.stateChanger);
          },
        ),
      ),
    );
  }

  Widget beacheItem(var machines, BuildContext context, String ip, String token,
      int index, final state) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xFFF082938)),
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
                        image: AssetImage('assets/images/iso.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(machines.value,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
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
                    children: <Widget>[],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget beacheItemIcon(IconData iconData, String text) {
    return Row(
      children: <Widget>[
        Icon(iconData, color: Colors.white),
        SizedBox(width: 2),
        Text(text, style: TextStyle(color: Colors.white))
      ],
    );
  }
}
