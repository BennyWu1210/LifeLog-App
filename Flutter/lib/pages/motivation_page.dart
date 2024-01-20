import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/input.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MotivationPage extends StatefulWidget {
  MotivationPage({super.key});

  @override
  State<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  String _quote = 'Press the button to generate a motivational quote!';

  Future<void> _generateQuote() async {
    const String apiUrl = 'http://localhost:8080/generate-quote';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "prompt":
            "Generate a motivation quote for somebody who wants to complete all their tasks!"
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _quote = data['quote'];
      });
    } else {
      setState(() {
        _quote = 'Failed to generate quote: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Motivation",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: bgcolor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 50),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: 0.75 * MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: lightgreen,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(
                        _quote,
                        style: const TextStyle(
                            fontSize: 18,
                            color: dark,
                            fontWeight: FontWeight.w400),
                      ))),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.125 * MediaQuery.of(context).size.width),
                child:
                    CoolButton(text: "Generate Quote", handler: _generateQuote))
          ],
        ));
  }
}
