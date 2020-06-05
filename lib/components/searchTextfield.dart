import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<SuperState>(context);
    return TextField(
        onChanged:(text){
          print("First text field: $text");
          prov.search(name: text);
          } ,
        style: TextStyle(color: Color(0xFFF234253),fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: "Rechercher",
          labelStyle: TextStyle(color: Color(0xFFF234353),fontWeight: FontWeight.bold),
          prefixIcon: Icon(Icons.search,size: 28),
          fillColor: Color(0xFFFeaf2f4),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12)
          )
        ),
    );
  }
}