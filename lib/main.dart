import 'package:mobileapp_sepeda/ui/berandaadmin.dart';
import 'package:mobileapp_sepeda/ui/berandauser.dart';
import 'package:mobileapp_sepeda/ui/home.dart';
import 'package:mobileapp_sepeda/ui/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      title: 'Penjualan Sepeda',
      home: Berandauser(),
      routes: <String, WidgetBuilder>{
        '/Berandauser': (BuildContext context) => new Berandauser(),
        '/Berandaadmin': (BuildContext context) => new Berandaadmin(),
        '/login': (BuildContext context) => Login(),
        '/Penjualan': (BuildContext context) => new Home(),
      },
    ));
