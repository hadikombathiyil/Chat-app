import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/localstorage.dart';
import 'package:whatsapp/view/chatscreen/cubit/chatcubit_cubit.dart';
import 'package:whatsapp/view/loginscreen/loginscreen.dart';
import 'package:whatsapp/view/userscreen/userscreen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashData() async {
     token =await LocalStorage.getData();
     print("????????????////////$token");
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => token == null ? Loginscreen() : Userscreen(),
    ));
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),splashData);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(child: Text("WELCOME",),),
);
}
}