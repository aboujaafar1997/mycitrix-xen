import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 70,),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/images/user_5.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
          SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Administrateur", style: TextStyle(
                  color: Color(0xFFF2c4e5e),
                  fontWeight: FontWeight.bold
                  ,fontSize: 20
              )),
              Text("Root", style: TextStyle(
                  color: Color(0xFFF1f94aa)
              )),
            ],
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/addVm");

            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.video_label),
                ),
                Text("Ajouter un VM",style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          GestureDetector(
            onTap:()=>Navigator.pushNamed(context, "/addNet"),
            child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
             IconButton(
               icon: Icon(Icons.blur_on),
             ),
             Text("Ajouter un Réseau",style: TextStyle(fontSize: 20)),
         ],
       ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.dns),
              ),
              Text("Ajouter un Storage",style: TextStyle(fontSize: 20)),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/profil");
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.brightness_low),
                ),
                Text("Paramètres du compte",style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/log");
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.insert_drive_file),
                ),
                Text("Log de compte",style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                ),
                Text("Quitter",style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}