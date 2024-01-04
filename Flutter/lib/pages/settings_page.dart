import 'package:flutter/material.dart';
import 'package:journal_app/pages/settings_subpages.dart';
import 'package:journal_app/style/style.dart';

class SettingsPage extends StatelessWidget {
  // This should take in a user instance
  final String username = "Benny_Wu123";
  final String image_url = "assets/images/sample_profile.jpg";
  const SettingsPage({super.key});

  @override
  Widget build(context) {
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
                child: Image.asset(image_url, width: 90)),
            const SizedBox(
              height: 15,
            ),
            Text(
              username,
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
                        builder: (context) => const ProfilePicturePage()),
                    const Divider(
                      thickness: 1,
                      indent: 25,
                      color: Color.fromRGBO(20, 20, 20, 0.1),
                    ),
                    SettingsItem(
                        title: "Change Password",
                        bolded: false,
                        builder: (context) => const PasswordPage()),
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
                        builder: (context) => const SettingsPage()),
                    const SizedBox(
                      height: 15,
                    )
                  ]),
                )),
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
