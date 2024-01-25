import 'package:flutter/material.dart';
import 'package:journal_app/app.dart';
import 'package:journal_app/pages/settings_subpages.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/goal_template.dart';
import 'package:journal_app/utilities/input.dart';
import 'package:journal_app/utilities/journal_template.dart';

import '../utilities/user_data.dart';

class SettingsPage extends StatelessWidget {
  User user;
  final Function(User) updateUser;
  final Function() removePrefs;
  final dynamic Function() syncWithCloud;

  // This should take in a user instance
  //String username = "Benny_Wu123";

  final String image_url = "assets/images/sample_profile.png";

  SettingsPage(
      {super.key,
      required this.user,
      required this.updateUser,
      required this.syncWithCloud,
      required this.removePrefs});

  @override
  Widget build(context) {
    print("settings page: $user");

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: bgcolor,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          alignment: Alignment.center,
          child: Column(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: user.profilePicture,
                  width: 90,
                )),
            const SizedBox(
              height: 15,
            ),
            Text(
              user.username,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: poopoo,
                  child: Column(children: [
                    const SizedBox(height: 20),
                    SettingsItem(
                        title: "Change Profile Picture",
                        bolded: false,
                        builder: (context) => ProfilePicturePage(
                              user: user,
                              updateUser: updateUser,
                            )),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "Change Username",
                        bolded: false,
                        builder: (context) => UsernamePage(
                              user: user,
                              updateUser: updateUser,
                            )),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "Change Password",
                        bolded: false,
                        builder: (context) => PasswordPage(
                              user: user,
                              updateUser: updateUser,
                            )),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "Friends List",
                        bolded: false,
                        builder: (context) => const FriendsListPage()),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "About Us",
                        bolded: false,
                        builder: (context) => const AboutUs()),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "Log Out",
                        bolded: true,
                        builder: (context) => const Placeholder(),
                        removePrefs: removePrefs),
                    const SizedBox(
                      height: 15,
                    )
                  ]),
                )),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CoolButton(
                  text: "Sync With Cloud",
                  handler:
                      syncWithCloud) // should trigger an update in "MyHomePage" that sends all local change to the cloud
              ,
            )
            // Text(user.profilePicturePath!) // Null value ??????????????????
          ]),
        ));
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final bool bolded; // which implies logout lol
  final Widget Function(BuildContext) builder;
  final Function()? removePrefs;

  const SettingsItem(
      {Key? key,
      required this.title,
      required this.builder,
      required this.bolded,
      this.removePrefs})
      : super(key: key);

  @override
  Widget build(context) {
    return GestureDetector(
        onTap: () {
          if (!bolded) {
            Navigator.push(context, MaterialPageRoute(builder: builder));
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const App()),
                (Route<dynamic> route) => false);
            print("a");
            removePrefs!(); // definitely good practice
            // cannot pass function in from above
          }
        },
        child: Container(
          color: poopoo,
          padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: bolded ? FontWeight.bold : null),
          ),
        ));
  }
}
