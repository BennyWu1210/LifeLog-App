import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/pages/home_page.dart';
import 'package:journal_app/utilities/local_storage.dart';
import 'package:journal_app/utilities/user_data.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  // App variables
  late User user = User.empty(); // use empty user while the real user loads

  void loadUser() async {
    user = await readUser();
  }

  @override
  void initState(){
    super.initState();
    loadUser();
    print("----------- init user ----------------");

    // TODO: BELOW IS TEMP CODE BEFORE THE IMPLEMENTATION OF AUTH
    User placeholder = User("Coolestbenny", "123456");
    // updateUserInfo(placeholder); // Run this first to apply data to the local file, then you can comment it out
    print("apppage:  " + user.toString());
  }

  void updateUserInfo(User u){
    setState(() {
      user = u;
      writeUser(u);
    });
    print("- updated user info");
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage(updateUser: updateUserInfo, user: user,);
  }

}