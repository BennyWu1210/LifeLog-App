import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/pages/journal.dart';
import 'package:intl/intl.dart';



// Custom files
import '../utilities/journal_template.dart';
import '../style/style.dart';
import 'journal_page.dart';
import '../utilities/local_storage.dart';
import '../pages/settings_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  The list containing the journals and the function for updating the list
   */

// TODO: These dummy data should be in the form of json files (for "fake" fetching).
// This enables a smoother transition to backend fetching

  List<Journal> journalList = [];

  void loadJournals() async{
    journalList = await readJournals();
  }

  @override
  void initState() {
    super.initState();
    loadJournals();
    print("-------------------- FIRST LOAD -----------------------------");
    print(journalList.length);
  }

  late List<bool> journalDropdown = List<bool>.generate(journalList.length, (index) => false);


  void addJournal(Journal j) {
    setState(() {
      journalList.add(j);
      journalDropdown.add(false);
      writeJournals(journalList);
    });
  }

  void deleteJournal(int idx){
    setState(() {
      journalList.removeAt(idx);
      journalDropdown.removeAt(idx);
      writeJournals(journalList);
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
                child: FutureBuilder<List<Journal>>(
                  future: readJournals(),
                  builder: (BuildContext context, AsyncSnapshot<List<Journal>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 60,
                          child: const LinearProgressIndicator()
                      );
                    }
                    else{
                      print("------------------- LISTVIEW LOAD ----------------------");
                      print(journalList.length);
                      return ListView.builder(
                        itemCount: journalList.length,
                        shrinkWrap: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 0),
                              child: GestureDetector(
                                  onLongPress: (){
                                    setState(() {
                                      journalDropdown[index] = !journalDropdown[index];
                                    });
                                    HapticFeedback.heavyImpact(); // TODO: This does not work on Huawei phone
                                  },
                                  child: Column(
                                    children: [
                                      Card(
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
                                              "${DateFormat("MMMM dd, yyyy").format(journalList[index].time)}  |  ${journalList[index].content}",
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

                                      // Dropdown menu when long pressed
                                      // TODO: This animation may cause overflow, needs improvement
                                      AnimatedContainer(
                                          duration: const Duration(milliseconds: 60), // Adjust duration as needed
                                          height: journalDropdown[index] ? 60.0 : 0.0, // Adjust height as needed
                                          child:
                                          journalDropdown[index]? Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  deleteJournal(index);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.delete, color: Colors.white,),
                                                    SizedBox(width: 10.0), // Add some spacing between the logo and the text
                                                    Text('Delete', style: TextStyle(color: Colors.white, fontSize: 15),),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ) : const SizedBox()
                                      )
                                    ],
                                  )
                              )
                          );
                        },
                      );

                    }
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
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SettingsPage()));
                    },
                    tooltip: 'Settings',
                    icon: const Icon(
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
