import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/pages/home_page.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/input.dart';
import 'package:journal_app/backend/backend.dart';
import '../utilities/user_data.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  SignupPage({Key? key}) : super(key: key);

  Widget popup(BuildContext context, String msg) {
    return AlertDialog(
      title: Text(
        msg,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text("Close"))
      ],
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "New Account",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: bgcolor,
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 105),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Username"),
                  controller: usernameController,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 80),
                CoolButton(
                    handler: () async {
                      if (usernameController.text == '' ||
                          passwordController.text == '') {
                        // popup
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => popup(context, "Please do not leave the username or the password blank"));
                      }
                      else if (passwordController.text.length < 6){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => popup(context, "Please choose a password that has more than 6 characters"));
                      }
                      else {

                      }
                    },
                    text: "Sign Up"),
                const SizedBox(height: 20,),

              ],
            )));
  }
}
