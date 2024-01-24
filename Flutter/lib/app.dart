import 'package:flutter/material.dart';
import 'package:journal_app/pages/home_page.dart';
import 'package:journal_app/pages/login_page.dart';
import 'package:journal_app/utilities/goal_template.dart';
import 'package:journal_app/utilities/journal_template.dart';
import 'package:journal_app/utilities/local_storage.dart';
import 'package:journal_app/utilities/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class App extends StatefulWidget {
  final int loadingStatePreset;
  const App({super.key, required this.loadingStatePreset});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // App variables
  late User user; // use empty user while the real user loads
  late SharedPreferences prefs;
  late int loadingState = widget.loadingStatePreset;

  /*
  Case 1: -1 -> logged out / new user
  go to login page

  Case 2: valid user id -> not logged out
  use the id to readUser

  loadingState:
  -1 : initial state
  0: sharedPrefs retrieved
  1: go to login page
  2: go to homepage
   */

  void loadPrefsAndUser() async {
    prefs = await getLoginState();
    loadingState = 0;
    int? id = prefs.getInt('id');
    if (id == null) {
      loadingState = 1;
      setState(() {});
      return;
    }
    user = await readUser(id);
    loadingState = 2;
    setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   backendGet(); // TODO: Remove this test code for connecting to backend
  //   // loadUser();
  //   print("----------- init user ----------------");

  //   print("apppage:  " + futureUser.toString());
  // }

  @override
  void initState() {
    super.initState();
    if (loadingState == 1){
      return;
    }
    loadingState = -1;
    loadPrefsAndUser();

  }

  Future<void> updateUserInfo(User u) async {
    user = u;
    setState(() {
      writeUser(u, u.userid, overwrite: true);
    });
    print("- updated user info");
    print(user);
  }

  void updatePrefs(int id) {
    prefs.setInt('id', id);
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<User>(
    //     future: futureUser,
    //     builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // The Future is resolved
    //         // return MyHomePage(updateUser: updateUserInfo, user: snapshot.data!);
    //         return LoginPage(updateUser: updateUserInfo);
    //       } else {
    //         // The Future is still running
    //         return const CircularProgressIndicator(); // Show a loading spinner
    //       }
    //     });
    switch (loadingState) {
      case (1):
        return LoginPage(updateUser: updateUserInfo, updatePrefs: updatePrefs,);
      case(2):
        return MyHomePage(user: user, updateUser: updateUserInfo, updatePrefs: updatePrefs,);
      default:
        return const CircularProgressIndicator();
    }
  }
}
