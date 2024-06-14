import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../localstorage.dart';
import '../../userscreen/userscreen.dart';

part 'registercubit_state.dart';

class RegistercubitCubit extends Cubit<RegistercubitState> {
  RegistercubitCubit(this.context) : super(RegistercubitInitial());
  BuildContext context;
  String? token;

  TextEditingController usrName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController confPassword = TextEditingController();

  userRegister() async {
    if (usrName.text.isNotEmpty && passWord.text.isNotEmpty)
      try {
        UserCredential? user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: passWord.text.trim());
        if (user.user!.uid.isNotEmpty) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(user!.user!.uid);
          token = user!.user!.uid;
          await FirebaseFirestore.instance.collection("user").add({
            "usermail": email.text.trim(),
            "userid": user.user!.uid,
            "username": usrName.text.trim()
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Userscreen(),
          ));
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
  }
}
