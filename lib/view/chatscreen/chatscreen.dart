import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/view/chatscreen/cubit/chatcubit_cubit.dart';
import 'package:whatsapp/view/loginscreen/loginscreen.dart';

class Chatscreen extends StatelessWidget {
  Chatscreen({super.key, required this.userId, required this.name});
  final String userId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$userId"),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () async {
                    //
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Loginscreen(),
                    ));
                  },
                  child: Icon(Icons.logout)),
            )
          ],
        ),
        body: BlocProvider(
          create: (context) => ChatcubitCubit(context, userId, name),
          child: BlocBuilder<ChatcubitCubit, ChatcubitState>(
            builder: (context, state) {
              final cubit = context.read<ChatcubitCubit>();
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("message")
                      .doc(token)
                      .collection(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var sender = snapshot.data!.docs;
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("message")
                              .doc(userId)
                              .collection(token!)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            var reciver = snapshot.data!.docs;
                            List storevalues = List.from(sender)..addAll(reciver);
                            storevalues.sort(
                              (a, b) {
                                var firstMsg =
                                    DateTime.parse(a["time"]).toString();
                                var secondMsg =
                                    DateTime.parse(b["time"]).toString();
                                return firstMsg.compareTo(secondMsg);
                              },
                            );

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: storevalues.length,
                                  itemBuilder: (context, index) {
                                    return BubbleSpecialThree(
                                      text: storevalues[index]["message"]
                                          .toString(),
                                      textStyle: TextStyle(color: Colors.white),
                                      color: Colors.black,
                                      isSender:
                                          token == storevalues[index]["sender"]
                                              ? true
                                              : false,
                                    );
                                  },
                                )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TextFormField(
                                    controller: cubit.textctr,
                                    decoration: InputDecoration(
                                        labelText: "Message",
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              cubit.datastore();
                                            },
                                            icon: const Icon(Icons.send))),
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  });
            },
          ),
        ));
  }
}
