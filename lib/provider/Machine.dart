import 'package:citrixmobile/models/beachesModel.dart';
import 'package:flutter/cupertino.dart';

class MachineState with ChangeNotifier{
  List<BeachesModel> beachesp = [
    BeachesModel(
        title: "Windows",
        desc: "text of the printing",
        img: "assets/images/windows.png",
        isActive: true
    ),
    BeachesModel(
        title: "Mac OS",
        desc: "Contrary to popular belief",
        img: "assets/images/mac.jpg",
        isActive: true
    ),
    BeachesModel(
        title: "Ubunto",
        desc: "Contrary to popular belief",
        img: "assets/images/ubunto.png",
        isActive: true
    ),
    BeachesModel(
        title: "Windows",
        desc: "Contrary to popular belief",
        img: "assets/images/windows.png",
        isActive: true
    )
  ];
    List<BeachesModel> beaches = [
      BeachesModel(
          title: "Windows",
          desc: "text of the printing",
          img: "assets/images/windows.png",
          isActive: true
      ),
      BeachesModel(
          title: "Mac OS",
          desc: "Contrary to popular belief",
          img: "assets/images/mac.jpg",
          isActive: true
      ),
      BeachesModel(
          title: "Ubunto",
          desc: "Contrary to popular belief",
          img: "assets/images/ubunto.png",
          isActive: true
      ),
      BeachesModel(
          title: "Windows",
          desc: "Contrary to popular belief",
          img: "assets/images/windows.png",
          isActive: true
      )
  ];
  search({name}){
    this.beaches = beachesp.where((i) => i.title.toUpperCase().startsWith(name.toUpperCase())).toList();
    notifyListeners();
  }
}