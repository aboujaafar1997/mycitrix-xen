import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:citrixmobile/animations/fadeAnimation.dart';
import 'package:citrixmobile/components/customButtonAnimation.dart';
import 'package:citrixmobile/screens/loginScreen.dart';
import 'package:provider/provider.dart';

import 'SinginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<SuperState>(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/images/home.jpg", fit: BoxFit.cover),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFF001117).withOpacity(0.7),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            margin: EdgeInsets.only(top: 80, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  FadeAnimation(2.4,Text("Hi!", style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 2
                ))),
                 FadeAnimation(2.6,Text("MyCitrix", style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                   letterSpacing: 2.0
                ))),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(2.8,CustomButtonAnimation(
                      label: "S'inscrire",
                      backbround: Colors.transparent,
                      fontColor: Colors.white,
                      borderColor: Colors.white,
                      child: SinginScreen(),
                    )),
                    SizedBox(height: 20),
                    FadeAnimation(3.2,CustomButtonAnimation(
                      label: "Connectez-vous",
                      backbround: Colors.white,
                      borderColor: Colors.white,
                      fontColor: Color(0xFFF001117),
                      child: LoginScreen(),
                    )),
                    SizedBox(height: 30),
                    FadeAnimation(3.4,Text("Mot de passe oublié?", style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      decoration: TextDecoration.underline
                    )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}