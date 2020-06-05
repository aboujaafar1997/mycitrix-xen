import 'package:citrixmobile/provider/Super.dart';
import 'package:citrixmobile/screens/AddNetwork.dart';
import 'package:citrixmobile/screens/AddVm.dart';
import 'package:citrixmobile/screens/Info.dart';
import 'package:citrixmobile/screens/Log.dart';
import 'package:citrixmobile/screens/dashScreen.dart';
import 'package:citrixmobile/screens/profil.dart';
import 'package:citrixmobile/screens/vifs.dart';
import 'package:flutter/material.dart';
import 'package:citrixmobile/screens/homeScreen.dart';
import 'package:citrixmobile/screens/Vif.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => SuperState())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mcitrix',
        initialRoute: "/",
        routes: {
          '/vifs': (context) => Vifs(),
          '/profil': (context) => Profil(),
          '/': (context) => HomeScreen(),
          '/info': (context) => Info(),
          '/machines': (context) => DashScreen(),
          '/addvifَ': (context) => Vif(),
          '/vif': (context) => Vif(),
          '/addVm': (context) => AddVm(),
          '/addNet': (context) => AddNetwork(),
          '/log':(context)=>Log()
        },
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
      ),
    );
  }
}
