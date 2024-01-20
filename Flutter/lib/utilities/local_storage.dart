import 'dart:convert';
import 'package:journal_app/utilities/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'goal_template.dart';
import 'journal_template.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/*
----------- Journals Storage --------------
 */

Future<File> get _localJournalFile async {
  final path = await _localPath;
  return File('$path/journals.json');
}

Future<File> writeJournals(List<Journal> jList) async {
  final file = await _localJournalFile;
  final List<Map<String, dynamic>> jsonList = [];
  for (Journal j in jList) {
    jsonList.add(j.toJson());
  }
  return file.writeAsString(jsonEncode(jsonList));
}

Future<List<Journal>> readJournals() async {
  try {
    final file = await _localJournalFile;

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

Future<File> get _localUserFile async {
  final path = await _localPath;
  return File("$path/userdata.json");
}

Future<File> writeUser(User u) async {
  final file = await _localUserFile;
  return file.writeAsString(jsonEncode(u.toJson()));
}

Future<User> readUser() async {
  try {
    final file = await _localUserFile;

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

Future<File> get _localGoalsFile async {
  final path = await _localPath;
  return File('$path/goals.json');
}

void writeGoals(List<Goal> gl) async {
  final file = await _localGoalsFile;
  final List<Map<String, dynamic>> jsonList = [];
  for (Goal g in gl) {
    jsonList.add(g.toJson());
  }
  file.writeAsString(jsonEncode(jsonList));
}

Future<List<Goal>> readGoals() async {
  try {
    final file = await _localGoalsFile;
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
