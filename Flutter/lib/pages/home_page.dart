import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/pages/journal.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/pages/motivation_page.dart';
import 'package:journal_app/utilities/goal_template.dart';
import 'package:journal_app/utilities/goals_overview.dart';
import 'package:journal_app/utilities/input.dart';

// Custom files
import '../utilities/journal_template.dart';
import '../style/style.dart';
import '../utilities/user_data.dart';
import 'journal_page.dart';
import '../utilities/local_storage.dart';
import '../pages/settings_page.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  final Function(User) updateUser;

  const MyHomePage({super.key, required this.user, required this.updateUser});

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
  /* List<Goal> goalList = [
    TodoGoal(title: "Say Hi to Friends", state: false),
    ProgressGoal(title: "Go to lecture", current: 12, total: 30),
    ProgressGoal(title: "Haidilao", current: 15, total: 15, completed: true),
    TodoGoal(title: "Start juanning", state: true, completed: true),
  ];
   */
  List<Goal> goalList = [];

  void loadJournalsAndGoals() async {
    journalList = await readJournals();
    goalList = await readGoals();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadJournalsAndGoals();

    // Run this code once to load goals into storage
    // writeGoals([
    // TodoGoal(title: "Say Hi to Friends", state: false),
    // ProgressGoal(title: "Go to lecture", current: 12, total: 30),
    // ProgressGoal(title: "Haidilao", current: 15, total: 15, completed: true),
    // TodoGoal(title: "Start juanning", state: true, completed: true),
    // ]);

    print("-------------------- FIRST LOAD -----------------------------");
    print("journalList length: ${journalList.length}");
    print("goalList length: ${goalList.length}");
  }

  late List<bool> journalDropdown =
      List<bool>.generate(journalList.length, (index) => false);

  void addGoal(Goal g) {
    setState(() {
      goalList.add(g);
      writeGoals(goalList);
    });
  }

  void toggleGoal(TodoGoal g) {
    setState(() {
      g.state = !g.state;
      g.completed = g.state;
      writeGoals(goalList);
    });
  }

  int countTodoGoals() {
    int count = 0;
    for (Goal goal in goalList) {
      if (goal is TodoGoal) {
        count++;
      }
    }
    return count;
  }

  int countProgressGoals() {
    int count = 0;
    for (Goal goal in goalList) {
      if (goal is TodoGoal) {
        count++;
      }
    }
    return count;
  }

  int countCompletedGoals() {
    int count = 0;
    for (Goal goal in goalList) {
      if (goal.completed == true) {
        count++;
      }
    }
    return count;
  }

  void changeValGoal(ProgressGoal g, int val) {
    setState(() {
      g.current = val;
      g.completed = g.current == g.total;
      writeGoals(goalList);
    });
  }

  void removeGoal(int idx) {
    setState(() {
      goalList.removeAt(idx);
      writeGoals(goalList);
    });
  }

  void addJournal(Journal j) {
    setState(() {
      journalList.add(j);
      journalDropdown.add(false);
      writeJournals(journalList);
    });
  }

  void deleteJournal(int idx) {
    setState(() {
      journalList.removeAt(idx);
      journalDropdown.removeAt(idx);
      writeJournals(journalList);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("homepage: " + widget.user.toString());
    print("homepage: ${goalList.length}");

    // Get the number of td and prog goals for the goal preview page
    final int todoCount = countTodoGoals();
    final int progressCount = countProgressGoals();
    final int completedCount = countCompletedGoals();
    print("completedCount: $completedCount");

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
          // Goals Overview
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 45),
            child: Text(
              "My Goals",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 30),
              child: GoalsOverview(
                  todoCount: todoCount,
                  progressCount: progressCount,
                  completedCount: completedCount,
                  goals: goalList,
                  addGoal: addGoal,
                  removeGoal: removeGoal,
                  toggleGoal: toggleGoal,
                  changeValGoal: changeValGoal)),

          Padding(
              padding: const EdgeInsets.only(
                  top: 220,
                  bottom: 110,
                  left: 25,
                  right: 25), //vertical: 200, horizontal: 25
              child: FutureBuilder<List<Journal>>(
                future: readJournals(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Journal>> snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return SizedBox(
                  //       height: MediaQuery.of(context).size.height - 60,
                  //       child: const LinearProgressIndicator());
                  // } else {
                  print(
                      "------------------- LISTVIEW LOAD ----------------------");
                  print(journalList.length);
                  return ListView.builder(
                    itemCount: journalList.length,
                    shrinkWrap: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 0),
                          child: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  journalDropdown[index] =
                                      !journalDropdown[index];
                                });
                                HapticFeedback
                                    .heavyImpact(); // TODO: This does not work on Huawei phone (benny: LMAOOOOOOO)
                              },
                              child: Column(
                                children: [
                                  Card(
                                    color: medgreen,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 6, 0, 6),
                                      child: ListTile(
                                        title: Text(journalList[index].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w900)),
                                        subtitle: Text(
                                          "${DateFormat("MMMM dd, yyyy").format(journalList[index].time)}  |  ${journalList[index].content}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      JournalPage(
                                                          journal: journalList[
                                                              index])));
                                        },
                                      ),
                                    ),
                                  ),

                                  // Dropdown menu when long pressed
                                  // TODO: This animation may cause overflow, needs improvement
                                  AnimatedContainer(
                                      duration: const Duration(
                                          milliseconds:
                                              60), // Adjust duration as needed
                                      height: journalDropdown[index]
                                          ? 60.0
                                          : 0.0, // Adjust height as needed
                                      child: journalDropdown[index]
                                          ? Column(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    deleteJournal(index);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              10.0), // Add some spacing between the logo and the text
                                                      Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          : const SizedBox())
                                ],
                              )));
                    },
                  );
                  // }
                },
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
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MotivationPage()));
                    },
                    tooltip: 'Friends',
                    icon: Icon(
                      Icons.group,
                      color: dark,
                      size: 30.0,
                    )),
                const SizedBox(
                  width: 40,
                ),
                addButton(() => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreatePostPage(
                                  addJournalCallback: addJournal)))
                    }),
                const SizedBox(
                  width: 40,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                  user: widget.user,
                                  updateUser: widget.updateUser)));
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
