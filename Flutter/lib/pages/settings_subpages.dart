import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/input.dart';

import '../utilities/user_data.dart';

class ProfilePicturePage extends StatelessWidget {
  final User user;
  final Function(User) updateUser;

  const ProfilePicturePage({Key? key, required this.user, required this.updateUser}) : super(key: key);

  Future imgPicker() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null){
        return;
      }
      final File imgFile = File(img.path); // cast XFile to File
      User newUser = user;
      newUser.profilePicturePath = imgFile.path;
      updateUser(newUser);
      print("---------- Imgpicker ---------------");
    }
    on PlatformException catch(e) {
      print("---------- IMGPICKER ERROR ---------------");
      print(e);
    }
  }

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
                addButton(() {
                  imgPicker();
                  Navigator.pop(context);

                })
              ],
            )));
  }
}



class UsernamePage extends StatelessWidget {

  final User user;
  final usernameController = TextEditingController();
  final Function updateUser;

  UsernamePage({Key? key, required this.user, required this.updateUser}) : super(key: key);

  @override
  Widget build(context) {
    User newUser;
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
                Text("Please input new username"),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Your Username"
                  ),
                  controller: usernameController,

                ),
                SizedBox(height: 20),
                CoolButton(handler: (){
                  newUser = user;
                  newUser.username = usernameController.text;
                  updateUser(newUser);
                  Navigator.pop(context);
                }, text: "Update")
              ],
            )));
  }
}



class PasswordPage extends StatelessWidget {

  final User user;
  final passwordController = TextEditingController();
  final Function updateUser;

  PasswordPage({Key? key, required this.user, required this.updateUser}) : super(key: key);

  @override
  Widget build(context) {
    User newUser;
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
                TextFormField(
                  obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Your Password"
                    ),
                  controller: passwordController,

                ),
                SizedBox(height: 20),
                CoolButton(handler: (){
                  newUser = User(user.username, passwordController.text, profilePicturePath: user.profilePicturePath);
                  updateUser(newUser);
                  Navigator.pop(context);
                }, text: "Update")
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
