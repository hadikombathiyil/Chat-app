
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/view/loginscreen/loginscreen.dart';
import 'package:whatsapp/view/registrationscreen/cubit/registercubit_cubit.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocProvider(
                  create: (context) => RegistercubitCubit(context),
                  child: BlocBuilder<RegistercubitCubit, RegistercubitState>(
                    builder: (context, state) {
                      final cubit = context.read<RegistercubitCubit>();
                      return SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               TextField(   controller: cubit.usrName,
                                decoration: InputDecoration(
                                    hintText: 'Username',
                                    border: OutlineInputBorder()),
                              ),
                              const SizedBox(height: 16.0),
                               TextField(controller: cubit.email,
                             
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.remove_red_eye),
                                    hintText: 'E-mail',
                                    border: OutlineInputBorder()),
                              ),
                              const SizedBox(height: 16.0),
                               TextField(    controller: cubit.passWord,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.remove_red_eye),
                                    hintText: 'Password',
                                    border: OutlineInputBorder()),
                              ),
                               SizedBox(height: 16.0),
                               TextField(    controller: cubit.confPassword,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.remove_red_eye),
                                    hintText: 'Confirm Password',
                                    border: OutlineInputBorder()),
                              ),
                              const SizedBox(height: 50.0),
                              GestureDetector(
                                onTap: () {
                                  cubit.userRegister();
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
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Loginscreen(),
                                        ));
                                  },
                                  child: const Text("Login"))
                            ]),
                      );
                    },
                  ),
                ))));
  }
}
