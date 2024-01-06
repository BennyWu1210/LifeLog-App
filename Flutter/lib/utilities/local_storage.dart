import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'journal_template.dart';



Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localJournalFile async {
  final path = await _localPath;
  return File('$path/journals.json');
}

Future<File> writeJournals(List<Journal> jList) async{
  final file = await _localJournalFile;
  final List<Map<String, dynamic>> jsonList = [];
  for (Journal j in jList){
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
    List<Journal> journals = data.map((item) => Journal.fromJson(item)).toList();

    return journals;
  } catch (e) {
    // If encountering an error, return an empty list
    print("---------- LOAD ERROR --------------");
    return [];
  }
}

