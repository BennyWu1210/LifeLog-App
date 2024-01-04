import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom files
import 'journal.dart';
import 'style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/*
  ----------------------- Homepage ----------------------------
 */
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

// These dummy data should be in the form of json files (for "fake" fetching).
// This enables a smoother transition to backend fetching

  List<Journal> journalList = [
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
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: ListView.builder(
                  itemCount: journalList.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 0),
                      child: Card(
                        color: medgreen,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 0),
                          child: ListTile(
                            title: Text(journalList[index].title,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            textColor: Colors.white,
                            subtitle: Text(
                              journalList[index].content,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            onTap: () {
                              // Navigate to the journal entry page
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
                const FloatingActionButton(
                    onPressed: null,
                    tooltip: 'Friends',
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Icon(
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
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 35.0,
                    )),
                const SizedBox(
                  width: 40,
                ),
                const FloatingActionButton(
                    onPressed: null,
                    tooltip: 'Settings',
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Icon(
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

/*
  ----------------------- Post Page ----------------------------
 */

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
            widget.addJournalCallback(Journal(
                title: journalTitleController.text,
                content: journalTextController.text));
            journalTextController.clear();
            journalTitleController.clear();
            Navigator.pop(context);
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
