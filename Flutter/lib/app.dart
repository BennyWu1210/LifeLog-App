import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/backend/backend.dart';
import 'package:journal_app/pages/home_page.dart';
import 'package:journal_app/pages/login_page.dart';
import 'package:journal_app/utilities/local_storage.dart';
import 'package:journal_app/utilities/user_data.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  // App variables
  late Future<User> futureUser; // use empty user while the real user loads

  void loadUser() async {
    futureUser = readUser();
  }

  @override
  void initState(){
    super.initState();
    backendGet(); // TODO: Remove this test code for connecting to backend
    loadUser();
    print("----------- init user ----------------");

    print("apppage:  " + futureUser.toString());
  }

  Future<void> updateUserInfo(User u) async {
    User user = await futureUser;
    user = u;
    setState(() {
      writeUser(u);
      futureUser = Future.value(user);
    });
    print("- updated user info");
    print(user);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>
      (
        future: futureUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // The Future is resolved
            // return MyHomePage(updateUser: updateUserInfo, user: snapshot.data!);
            return LoginPage(user: snapshot.data!, updateUser: updateUserInfo,);
          } else {
            // The Future is still running
            return const CircularProgressIndicator(); // Show a loading spinner
          }
        }
    );
  }

}