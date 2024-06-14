import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'chatcubit_state.dart';

String? token;

class ChatcubitCubit extends Cubit<ChatcubitState> {
  ChatcubitCubit(this.context, this.userId, this.name)
      : super(ChatcubitInitial());
  BuildContext context;
  TextEditingController textctr = TextEditingController();
  String userId;
  String name;

  datastore() async {
    FirebaseFirestore.instance
        .collection("message")
        .doc(token)
        .collection(userId)
        .add({
      "message": textctr.text,
      "time": DateTime.now().toString(),
      "user": name,
      "sender": token,
    });
  }
}
