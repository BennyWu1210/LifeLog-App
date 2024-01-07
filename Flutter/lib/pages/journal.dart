import 'package:flutter/material.dart';
import '../utilities/journal_template.dart';
import '../style/style.dart';
import 'package:intl/intl.dart';

class JournalPage extends StatelessWidget {
  final Journal journal;
  JournalPage({Key? key, required this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            journal.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
        backgroundColor: bgcolor,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Text(
            DateFormat("MMMM dd, yyyy").format(journal.time),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
        child: Column(
          children: <Widget>[
            Text(
              journal.content,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: dark),
            )
          ],
        ),
      ),
    );
  }
}
