import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:mobileapp_sepeda/ui/berandauser.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  Login({Key key, this.title});
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usr = new TextEditingController();
  TextEditingController psw = new TextEditingController();
  String msg = '';
  Future<String> _login() async {
    final response =
        await http.post("http://192.168.43.178/apiflutter/api/login", body: {
      "username": usr.text,
      "password": psw.text,
    });
    var datauser = json.decode(response.body);
    if (datauser['error'] == true) {
      setState(() {
        msg = datauser['msg'];
      });
    } else {
      String emailApi = datauser['email'];
      String namaApi = datauser['nama'];
      String id = datauser['id'];
      String photo = datauser['photo'];
      int level = int.parse(datauser['level']);
      setState(() {
        savePref(emailApi, namaApi, id, level, photo);
        msg = datauser['msg'];
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => Berandauser()));
    }
  }

  savePref(
      String email, String nama, String id, int level, String photo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("nama", nama);
      preferences.setString("emial", email);
      preferences.setString("id", id);
      preferences.setString("photo", photo);
      preferences.setInt("level", level);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(""), fit: BoxFit.cover)),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Image.asset("assets/appimages/bg_login.png", width: 50),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: usr,
                decoration: InputDecoration(
                    hintText: "Username",
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: psw,
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            RaisedButton(
              child: Row(
                children: <Widget>[Icon(Icons.verified_user), Text("Login")],
              ),
              color: Colors.blue,
              onPressed: () {
                _login();
              },
            ),
            Text(msg)
          ],
        ),
      ),
    );
  }
}
