import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/input.dart';
import 'package:http/http.dart' as http;

class MotivationPage extends StatefulWidget {
  MotivationPage({super.key});

  @override
  State<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  String poopoo = "Bill just change this lol, I don't know how to fix .env";
  // "sk-Zk

  String quote = "Your motivational quote will appear here.";

  final String apiUrl = "https://api.openai.com/v1/chat/completions";

  Future<void> generateQuote() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $poopoo',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        'messages': [
          {
            "role": "user",
            "content":
                "Generate a motivation quote for somebody who wants to complete all their task!"
          }
        ],
        'max_tokens': 200,
        'temperature': 0.85,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        quote = data['choices'][0]['message']['content'];
        print("HEH: ");
        print(data);
      });
    } else {
      print('Failed to generate quote: ${response.body}');
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
        ),
        body: Column(
          children: [
            SizedBox(height: 50),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: 0.75 * MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: BoxDecoration(
                      color: lightgreen,
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        quote,
                        style: const TextStyle(
                            fontSize: 22,
                            color: dark,
                            fontWeight: FontWeight.bold),
                      ))),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.125 * MediaQuery.of(context).size.width),
                child:
                    CoolButton(text: "Generate Quote", handler: generateQuote))
          ],
        ));
  }
}
