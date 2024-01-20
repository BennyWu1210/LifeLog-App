import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/pages/home_page.dart';
import 'package:journal_app/pages/signup_page.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/input.dart';
import 'package:journal_app/backend/backend.dart';
import '../utilities/user_data.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final User user;
  final Function(User) updateUser;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  LoginPage({Key? key, required this.user, required this.updateUser}) : super(key: key);

  Widget popup(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Please do not leave the username or the password blank",
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
            "Welcome Back!",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: bgcolor,
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 105),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            builder: (BuildContext context) => popup(context));
                      } else {
                        // TODO: implement login here
                        http.Response response = await authenticate(
                                usernameController.text,
                                passwordController.text)
                            .then((res) {
                          Map<String, dynamic> json = jsonDecode(res.body);
                          print(json['username']);
                          print(json['password']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                      user: user,
                                      updateUser: updateUser)));
                          return res;
                        });
                      }
                    },
                    text: "Log in"),
                const SizedBox(height: 35,),
                const Text("New user?"),
                const SizedBox(height: 10,),
                CoolButton(
                    text: "Sign Up",
                    handler: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignupPage()
                      ));

                    }
                )
              ],
            )));
  }
}
