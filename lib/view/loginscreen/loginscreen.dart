

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/view/loginscreen/cubit/logincubit_cubit.dart';

import '../registrationscreen/registerscreen.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocProvider(
                  create: (context) => LogincubitCubit(context),
                  child: BlocBuilder<LogincubitCubit, LogincubitState>(
                    builder: (context, state) {
                      final cubit = context.read<LogincubitCubit>();
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             TextField(controller: cubit.email,
                              decoration: InputDecoration(
                                  hintText: 'Username',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 16.0),
                             TextField(controller: cubit.passWord,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.remove_red_eye),
                                  hintText: 'Password',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 50.0),
                            GestureDetector(
                              onTap: () {
                                cubit.userLogin();
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Registerscreen(),
                                      ));
                                },
                                child: Text("Register"))
                          ]);
                    },
                  ),
                ))));
  }
}
