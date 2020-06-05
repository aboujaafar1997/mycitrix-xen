import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<SuperState>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF1f94aa).withOpacity(0.5),
            blurRadius: 5
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          profile(context,prov.user)
        ],
      ),
    );
  }

  Widget profile(context,String user){
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: ()=> Scaffold.of(context).openDrawer(),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/images/user_5.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
        ),
        SizedBox(width: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(user, style: TextStyle(
              color: Color(0xFFF2c4e5e),
              fontWeight: FontWeight.bold
            )),
            Text("Adminstrateur", style: TextStyle(
              color: Color(0xFFF1f94aa)
            )),
          ],
        ),
      ],
    );

  }

}