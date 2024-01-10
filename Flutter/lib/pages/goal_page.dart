import 'package:flutter/material.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/goal_template.dart';
import 'package:journal_app/utilities/goals_overview.dart';

class GoalPage extends StatelessWidget {
  final List<Goal> goals;
  late List<Goal> completedList;
  late List<Goal> incompletedList;
  final Function(Goal) addGoal;
  final Function(int) removeGoal;
  final Function(TodoGoal) toggleGoal;

  GoalPage({
    super.key,
    required this.goals,
    required this.addGoal,
    required this.removeGoal,
    required this.toggleGoal,
  }) {
    incompletedList = goals.where((element) => !element.completed).toList();
    completedList = goals.where((element) => element.completed).toList();
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(title: const Text("My Goals"), backgroundColor: bgcolor, centerTitle: true,),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "${completedList.length}/${goals.length} Completed",
              style: TextStyle(fontSize: 12),
            )),
            const Padding(
                padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                child: Text("In Progress",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Flexible(
              flex: 1,
              child: ListView.builder(
                  itemCount: incompletedList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              color: lightgreen,
                              height: 55, // hardcode gang
                              width: MediaQuery.of(context).size.width,
                              child: Column(children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 25,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                  child: Stack(
                                    children: [
                                      Text(
                                        incompletedList[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      incompletedList[index].type ==
                                              GoalType.progress
                                          ? progressBar(incompletedList[index]
                                              as ProgressGoal)
                                          : todoBox(
                                              incompletedList[index]
                                                  as TodoGoal,
                                              toggleGoal),
                                    ],
                                  ),
                                ),
                              ])),
                        ));
                  }),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                child: Text("Completed",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              child: ListView.builder(
                  itemCount: completedList.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              color: poopoo,
                              height: 55, // hardcode gang
                              width: MediaQuery.of(context).size.width,
                              child: Column(children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 25,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                  child: Stack(
                                    children: [
                                      Text(
                                        completedList[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      completedList[index].type ==
                                              GoalType.progress
                                          ? progressBar(completedList[index]
                                              as ProgressGoal)
                                          : todoBox(
                                              completedList[index] as TodoGoal,
                                              toggleGoal),
                                    ],
                                  ),
                                ),
                              ])),
                        ));
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add goal",
        backgroundColor: medgreen,
        onPressed: () {
              null;
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
