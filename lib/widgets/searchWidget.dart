import 'package:citrixmobile/provider/Machine.dart';
import 'package:citrixmobile/provider/Super.dart';
import 'package:flutter/material.dart';
import 'package:citrixmobile/components/searchTextfield.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<SuperState>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        children: <Widget>[
          Expanded(child: SearchTextField()),
          SizedBox(width: 11),
        ],
      ),
    );
  }
}