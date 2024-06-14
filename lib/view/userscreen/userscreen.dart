import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/localstorage.dart';
import 'package:whatsapp/view/chatscreen/chatscreen.dart';
import 'package:whatsapp/view/chatscreen/cubit/chatcubit_cubit.dart';

class Userscreen extends StatelessWidget {
  const Userscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Users"),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("user").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (snapshot.hasError) {
                return Center(
                  child: Text('Error:${snapshot.error}'),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: snapshot.data!.docs!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.red,
                            title: Text(snapshot.data!.docs[index]["username"]),
                            onTap: () async {
                              token = await LocalStorage.getData();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Chatscreen(
                                    name: "",
                                    userId: snapshot.data!.docs![index]
                                        ["userid"]),
                              ));
                            },
                          );
                        },
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
