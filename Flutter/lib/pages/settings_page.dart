import 'package:flutter/material.dart';
import 'package:journal_app/pages/settings_subpages.dart';
import 'package:journal_app/style/style.dart';

import '../utilities/user_data.dart';

class SettingsPage extends StatelessWidget {

  User user;
  final Function(User) updateUser;

  // This should take in a user instance
  //String username = "Benny_Wu123";

  final String image_url = "assets/images/sample_profile.jpg";

  SettingsPage({super.key, required this.user, required this.updateUser});

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
                child: Image(image: user.profilePicture, width: 90,)
            ),
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
                        builder: (context) => ProfilePicturePage(user: user, updateUser: updateUser,)),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "Change Username",
                        bolded: false,
                        builder: (context) => UsernamePage(user: user, updateUser: updateUser,)),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "Change Password",
                        bolded: false,
                        builder: (context) => PasswordPage(user: user, updateUser: updateUser,)),
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
                        builder: (context) => SettingsPage(user: user, updateUser: updateUser,)),
                    const SizedBox(
                      height: 15,
                    )
                  ]),
                )),
            Text(user.hash()),
            SizedBox(height: 20,),
            // Text(user.profilePicturePath!) // Null value ??????????????????
          ]),
        ));
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final bool bolded;
  final Widget Function(BuildContext) builder;

  const SettingsItem(
      {Key? key,
      required this.title,
      required this.builder,
      required this.bolded})
      : super(key: key);

  @override
  Widget build(context) {
    return GestureDetector(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: builder)),
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
