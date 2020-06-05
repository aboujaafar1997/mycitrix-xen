import 'dart:convert';

import 'package:citrixmobile/models/KeyValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class SuperState with ChangeNotifier {
  String ip = "http://192.168.1.20:8080";
  String token = "";
  String user = "uknow";
  ProgressDialog pr;
  List<dynamic> machines = [];
  List<dynamic> log = [];
  List<dynamic> machinesCopie = [];
  List<KeyValue> template = [];
  List<KeyValue> iso = [];
  List<KeyValue> sr = [];
  List<KeyValue> net = [];

  tokenChanger({mytoken, context}) async {
    mytoken != "" ? this.token = mytoken : null;
    this.net = [];
    this.sr = [];
    this.template = [];
    this.machines = [];
    this.iso = [];
    try {
      var url = this.ip + "/api/vm/getall";
      print(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${this.token}'
      };
      var response = await http.post(url, headers: headers);
      print('Respon Navigator.pop(context)se status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        this.machines = json.decode(response.body);
        this.machinesCopie = json.decode(response.body);
        gettemplate();
        getiso();
        getSr();
        getNetwork();
      } else {
        throw new Exception("Err de Connexion to XenServer");
      }
    } catch (ex) {
      print("+++++++++++++++++++++err+++++++++++++++++++++++++++${ex}");
    }
    notifyListeners();
  }

  getiso() async {
    try {
      var url = this.ip + "/api/vm/getiso";
      print(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${this.token}'
      };
      var response = await http.post(url, headers: headers);
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        data.forEach((k, v) {
          print(k + v);
          iso.add(KeyValue(k, v));
        });
      } else {
        throw new Exception("Err de iso");
      }
    } catch (ex) {
      print("*************err************** ${ex}");
    }
    notifyListeners();
  }

  getSr() async {
    try {
      var url = this.ip + "/api/vm/getsr";
      print(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${this.token}'
      };
      var response = await http.post(url, headers: headers);
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        data.forEach((k, v) {
          print(k + v);
          sr.add(KeyValue(k, v));
        });
      } else {
        throw new Exception("Err de sr");
      }
    } catch (ex) {
      print("*************err************** ${ex}");
    }
    notifyListeners();
  }

  getNetwork() async {
    try {
      var url = this.ip + "/api/vm/getnet";
      print(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${this.token}'
      };
      var response = await http.post(url, headers: headers);
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        data.forEach((k, v) {
          print(k + v);
          net.add(KeyValue(k, v));
        });
      } else {
        throw new Exception("Err de sr");
      }
    } catch (ex) {
      print("*************err************** ${ex}");
    }
    notifyListeners();
  }

  gettemplate() async {
    try {
      var url = this.ip + "/api/vm/templates";
      print(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${this.token}'
      };
      var response = await http.post(url, headers: headers);
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        data.forEach((k, v) {
          print(k + v);
          template.add(KeyValue(v, k));
        });
      } else {
        throw new Exception("Err de template");
      }
    } catch (ex) {
      print("*************err************** ${ex}");
    }
    notifyListeners();
  }

  nameChanger({myname}) {
    this.user = myname;
    notifyListeners();
  }

  stateChanger({index, state}) {
    this.machines[index]['statePower'] = state;
    notifyListeners();
  }
  getLog() async {
    try {
      this.log=[];
      var url = this.ip + "/api/vm/log";
      print(url);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${this.token}'
      };
      var response = await http.post(url, headers: headers);
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
         this.log = json.decode(response.body);
         print(log);
      } else {
        throw new Exception("Err de log");
      }
    } catch (ex) {
      print("*************err************** ${ex}");
    }
    notifyListeners();
  }


  search({name}) {
    this.machines = machinesCopie
        .where((i) => i['nameVm'].toUpperCase().startsWith(name.toUpperCase()))
        .toList();
    notifyListeners();
  }
}
