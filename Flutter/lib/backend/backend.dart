import 'package:http/http.dart' as http;

Future<void> backendGet() async {
  /*
  function for testing only

  android emulator:
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/ping'));

  ios emulator:
  final response = await http.get(Uri.parse('http://localhost:3000/ping'));
   */
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/journal'));
  print("#########\n########## backendGet");
  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
  print("");
}
