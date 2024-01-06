import 'package:flutter/material.dart';
import '../utilities/journal_template.dart';
import '../style/style.dart';

class CreatePostPage extends StatefulWidget {
  final Function(Journal) addJournalCallback;

  const CreatePostPage({Key? key, required this.addJournalCallback})
      : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final journalTitleController = TextEditingController();
  final journalTextController = TextEditingController();

  /*
  This popup shows when the user leaves the title or content blank
   */
  Widget popup(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Please do not leave the title or the content body blank",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text("Close"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Journal',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: bgcolor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12),
              // Journal Title
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Journal Title",
                    border: InputBorder.none,
                    hintText: "What's going on in your life?",
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.headlineSmall),
                style: Theme.of(context).textTheme.headlineSmall,
                controller: journalTitleController,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: lightgreen,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.only(
                  left: 20, top: 0, right: 20, bottom: 60),
              // Journal Body
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "How's it going?",
                    border: InputBorder.none,
                    labelStyle: Theme.of(context).textTheme.labelMedium),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: null,
                controller: journalTextController,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*
          Post journal
           */
            if (journalTitleController.text != "" &&
                journalTextController.text != "") {
              widget.addJournalCallback(Journal(
                  title: journalTitleController.text,
                  content: journalTextController.text,
                  time: DateTime.now()));
              journalTextController.clear();
              journalTitleController.clear();
              Navigator.pop(context);
            } else {
              // print("nuh uh");
              showDialog(
                  context: context,
                  builder: (BuildContext context) => popup(context));
            }
          },
          tooltip: "Post",
          backgroundColor: medgreen,
          child: const Icon(
            Icons.send,
            color: Colors.white,
            size: 26.0,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
