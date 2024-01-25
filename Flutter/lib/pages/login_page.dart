import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/pages/home_page.dart';
import 'package:journal_app/pages/signup_page.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/goal_template.dart';
import 'package:journal_app/utilities/input.dart';
import 'package:journal_app/backend/backend.dart';
import 'package:journal_app/utilities/journal_template.dart';
import 'package:journal_app/utilities/local_storage.dart';
import '../utilities/user_data.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final Function(User) updateUser;
  final Function(int) updatePrefs;
  final Function() removePrefs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  LoginPage(
      {Key? key,
      required this.updateUser,
      required this.updatePrefs,
      required this.removePrefs})
      : super(key: key);

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
                    handler: () {
                      if (usernameController.text == '' ||
                          passwordController.text == '') {
                        // popup
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => popup(context,
                                "Please do not leave the username or the password blank"));
                      } else {
                        authenticate(usernameController.text,
                                passwordController.text)
                            .then((res) {
                          if (res.statusCode != 200) {
                            print(res.body);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    popup(context, res.body));
                            return;
                          }

                          Map<String, dynamic> json = jsonDecode(res.body);

                          // overwrite local file with data from cloud
                          List<Goal> listOfGoals = [];
                          List<Journal> listOfJournal = [];
                          User user;

                          // fill goals
                          for (var goal in json['user']['goals']) {
                            if (goal['kind'] == 'ProgressType') {
                              listOfGoals.add(ProgressGoal(
                                  title: goal['title'],
                                  current: goal['current'],
                                  total: goal['total']));
                            } else {
                              listOfGoals.add(TodoGoal(
                                  title: goal['title'],
                                  state: goal['completed']));
                            }
                          }

                          // fill journals
                          for (var journal in json['user']['journals']) {
                            listOfJournal.add(Journal(
                                title: journal['title'],
                                content: journal['body'],
                                time: DateTime.parse(journal['createdAt'])));
                          }

                          // set user
                          user = User.fullInfo(
                              json['user']['username'],
                              json['user']["id"],
                              json['user']["hash"],
                              json['user']["salt"],
                              profilePicturePath: "");

                          // overwrite stuff
                          writeGoals(listOfGoals, user.userid, overwrite: true);
                          writeJournals(listOfJournal, user.userid,
                              overwrite: true);
                          writeUser(user, user.userid, overwrite: true);

                          // Update sharedPreferences
                          updatePrefs(user.userid);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                        user: user,
                                        updateUser: updateUser,
                                        updatePrefs: updatePrefs,
                                        removePrefs: removePrefs,
                                      )));
                        });
                      }
                    },
                    text: "Log in"),
                const SizedBox(
                  height: 35,
                ),
                const Text("New user?"),
                const SizedBox(
                  height: 10,
                ),
                CoolButton(
                    text: "Sign Up",
                    handler: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    })
              ],
            )));
  }
}
