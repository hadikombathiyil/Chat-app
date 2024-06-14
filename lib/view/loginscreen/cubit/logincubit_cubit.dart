import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/localstorage.dart';
import 'package:whatsapp/splashscreen.dart';
import 'package:whatsapp/view/chatscreen/cubit/chatcubit_cubit.dart';

part 'logincubit_state.dart';

class LogincubitCubit extends Cubit<LogincubitState> {
  LogincubitCubit(this.context) : super(LogincubitInitial()) {}
  BuildContext context;
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  userLogin() async {
    if (email.text.isNotEmpty && passWord.text.isNotEmpty) {
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: passWord.text.trim());
        if (user.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(user.user!.uid.toString());
          token = user.user!.uid;
           }
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ));
       
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error")));
    }
  }
}
