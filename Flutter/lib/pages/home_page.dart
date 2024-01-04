import 'package:flutter/material.dart';
import 'package:journal_app/pages/journal.dart';

// Custom files
import '../utilities/journal.dart';
import '../style/style.dart';
import 'journal_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  The list containing the journals and the function for updating the list
   */

// TODO: These dummy data should be in the form of json files (for "fake" fetching).
// This enables a smoother transition to backend fetching

  final List<Journal> journalList = [
    Journal(
        title: "Hello World",
        content:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
            "when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
            "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
            "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, "
            "and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    Journal(title: "Benny Orz", content: "je suis un vegetable"),
    Journal(
        title: "Dalao nb",
        content:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.text ever since the 1500s"),
  ];

  void addJournal(Journal j) {
    setState(() {
      journalList.add(j);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgcolor,
          centerTitle: true,
          scrolledUnderElevation: 0,
          title: Image.asset(
            'assets/images/lp_logo_l.png',
            scale: 4,
          )),
      body: Stack(
        children: <Widget>[
          // TODO: put list builder in separate class
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: ListView.builder(
                  itemCount: journalList.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 0),
                      child: Card(
                        color: medgreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 6, 0, 6),
                          child: ListTile(
                            title: Text(journalList[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900)),
                            subtitle: Text(
                              journalList[index].content,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => JournalPage(journal: journalList[index])
                                )
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),

          /*
            The bottom navbar consisting of three FABs in a row
             */
          Positioned(
            bottom: 30.0, // Adjust this value to move the buttons upwards
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const IconButton(
                    onPressed: null,
                    tooltip: 'Friends',
                    icon: Icon(
                      Icons.group,
                      color: dark,
                      size: 30.0,
                    )),
                const SizedBox(
                  width: 40,
                ),
                FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatePostPage(
                                  addJournalCallback: addJournal)));
                    },
                    tooltip: 'Increment',
                    backgroundColor: medgreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    heroTag: "navbarM",
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 35.0,
                    )),
                const SizedBox(
                  width: 40,
                ),
                const IconButton(
                    onPressed: null,
                    tooltip: 'Settings',
                    icon: Icon(
                      Icons.settings,
                      color: dark,
                      size: 30.0,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
    // floatingActionButton:
  }
}
