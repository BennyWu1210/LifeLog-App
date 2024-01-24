import 'dart:convert';
import 'package:journal_app/utilities/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'goal_template.dart';
import 'journal_template.dart';



Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<SharedPreferences> getLoginState() async {
  return SharedPreferences.getInstance();
}


/*
----------- Journals Storage --------------
 */

Future<File> _localJournalFile(int userId) async {
  final path = await _localPath;
  return File('$path/${userId}_journals.json');
}

Future<File> writeJournals(List<Journal> jList, int userId,
    {bool overwrite = false}) async {
  final file = await _localJournalFile(userId);
  final List<Map<String, dynamic>> jsonList = [];
  for (Journal j in jList) {
    jsonList.add(j.toJson());
  }
  // if (overwrite && await file.exists()) file.delete();
  return file.writeAsString(jsonEncode(jsonList));
}

Future<List<Journal>> readJournals(int userId) async {
  try {
    final file = await _localJournalFile(userId);

    // Read the file
    String contents = await file.readAsString();

    // Decode the string to a list of maps
    final data = jsonDecode(contents) as List;

    // Convert the list of maps to a list of Journals
    List<Journal> journals =
        data.map((item) => Journal.fromJson(item)).toList();

    return journals;
  } catch (e) {
    // If encountering an error, return an empty list
    print("---------- LOAD ERROR --------------");
    print(e);
    return [];
  }
}

/*
----------------- User data storage --------------------
 */

Future<File> _localUserFile(int userId) async {
  final path = await _localPath;
  return File("$path/${userId}_userdata.json");
}

Future<File> writeUser(User u, int userId, {bool overwrite = false}) async {
  final file = await _localUserFile(userId);
  // if (overwrite && await file.exists()) file.delete();
  return file.writeAsString(jsonEncode(u.toJson()));
}

Future<User> readUser(int userId) async {
  try {
    final file = await _localUserFile(userId);

    // Read the file
    String contents = await file.readAsString();

    // Decode the string to a list of maps
    final data = jsonDecode(contents);
    print("------------------ readUser: -------------------");
    print(data);
    return User.fromJson(data);
  } catch (e) {
    // If encountering an error, return an empty list
    print("---------- USER LOAD ERROR --------------");
    print(e);
    return User.empty();
  }
}

/*
--------------  Goals Data Storage  -----------------
 */

Future<File> _localGoalsFile(int userID) async {
  final path = await _localPath;
  return File('$path/${userID}_goals.json');
}

void writeGoals(List<Goal> gl, int userID, {bool overwrite = false}) async {
  final file = await _localGoalsFile(userID);
  final List<Map<String, dynamic>> jsonList = [];
  for (Goal g in gl) {
    jsonList.add(g.toJson());
  }
  // if (overwrite && await file.exists()) file.delete();
  file.writeAsString(jsonEncode(jsonList));
}

Future<List<Goal>> readGoals(int userID) async {
  try {
    final file = await _localGoalsFile(userID);
    String contents = await file.readAsString();
    final data = jsonDecode(contents) as List;
    List<Goal> goals = data.map((item) => Goal.fromJson(item)).toList();
    print("############## readGoals: ${goals.length}");
    return goals;
  } catch (e) {
    print("---------- GOALS LOAD ERROR --------------");
    print(e);
    return [];
  }
}
