import 'package:citrixmobile/components/MyDrawer.dart';
import 'package:citrixmobile/provider/Machine.dart';
import 'package:citrixmobile/screens/Iso.dart';
import 'package:citrixmobile/widgets/Machines.dart';
import 'package:citrixmobile/widgets/Networks.dart';
import 'package:citrixmobile/widgets/Storage.dart';
import 'package:flutter/material.dart';
import 'package:citrixmobile/animations/fadeAnimation.dart';
import 'package:citrixmobile/widgets/headerWidget.dart';
import 'package:citrixmobile/widgets/searchWidget.dart';
import 'package:provider/provider.dart';

class DashScreen extends StatefulWidget {
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MachineState())],
      child: Scaffold(
        drawer: Mydrawer(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(1.4, HeaderWidget()),
                SizedBox(height: 20),
                FadeAnimation(1.6, SearchWidget()),
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: Text("VMs :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            letterSpacing: 2.0))),
                SizedBox(height: 20),
                FadeAnimation(1.8, Machines()),
                SizedBox(height: 20),
                Divider(color: Colors.black),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: Text("Réseaux :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            letterSpacing: 2.0))),
                SizedBox(height: 20),
                FadeAnimation(2, Networks()),
                SizedBox(height: 20),
                Divider(color: Colors.black),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: Text("Storage :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            letterSpacing: 2.0))),
                SizedBox(height: 20),
                FadeAnimation(2, Storage()),
                SizedBox(height: 20),
                Divider(color: Colors.black),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: Text("ISO :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            letterSpacing: 2.0))),
                SizedBox(height: 20),
                FadeAnimation(2, Iso()),
                SizedBox(height: 20),
                Divider(color: Colors.black),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addVm');
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Colors.black)),
      ),
    );
  }
}
