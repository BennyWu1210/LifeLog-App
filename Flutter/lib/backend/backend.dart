import 'package:http/http.dart' as http;

Future<void> backendGet() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/ping'));
  print("################### backendGet");
  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
