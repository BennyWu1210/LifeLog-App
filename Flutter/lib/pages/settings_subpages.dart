import 'package:flutter/material.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/input.dart';

class ProfilePicturePage extends StatelessWidget {
  const ProfilePicturePage({Key? key}) : super(key: key);

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
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please upload new picture"),
                SizedBox(height: 10),
                addButton(() => {})
              ],
            )));
  }
}

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key}) : super(key: key);

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
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Please input new password"),
                SizedBox(height: 5),
                InputField(hint: "Your username"),
                SizedBox(height: 20),
                CoolButton(handler: () => {}, text: "Update")
              ],
            )));
  }
}

class FriendsListPage extends StatelessWidget {
  const FriendsListPage({Key? key}) : super(key: key);

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
        body: Text("Anime girls"));
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

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
        body: Text(
            "Please donate money we need money please please plase\n\n -Benny, Bill"));
  }
}
