import 'package:flutter/material.dart';
import '../utilities/journal_template.dart';
import '../style/style.dart';

class JournalPage extends StatefulWidget {
  final Journal journal;
  const JournalPage({Key? key, required this.journal})
      : super(key: key);

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.journal.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: bgcolor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
        child: Column(
          children: <Widget> [
            Text(
                widget.journal.content,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: dark),
            )
          ],
        ),
      ),
    );
  }
}