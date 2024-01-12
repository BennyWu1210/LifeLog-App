import 'package:flutter/material.dart';
import 'package:journal_app/pages/create_goal.dart';
import 'package:journal_app/pages/increment_progress.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/goal_template.dart';
import 'package:journal_app/utilities/goals_overview.dart';

class GoalPage extends StatefulWidget {
  final List<Goal> goals;
  final Function(Goal) addGoal;
  final Function(int) removeGoal;
  final Function(TodoGoal) toggleGoal;
  final Function(ProgressGoal, int) changeValGoal;

  const GoalPage({
    super.key,
    required this.goals,
    required this.addGoal,
    required this.removeGoal,
    required this.toggleGoal,
    required this.changeValGoal,
  });

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  late List<Goal> completedList;
  late List<Goal> incompletedList;

  void refreshToggle(TodoGoal g) {
    widget.toggleGoal(g);
    _updateGoalLists();
    setState(() {});
  }

  void refreshValue(ProgressGoal g, int value) {
    widget.changeValGoal(g, value);
    _updateGoalLists();
    setState(() {});
  }

  @override
  void initState() {
    _updateGoalLists();
  }

  void _updateGoalLists() {
    setState(() {
      incompletedList =
          widget.goals.where((element) => !element.completed).toList();
      completedList =
          widget.goals.where((element) => element.completed).toList();
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Goals"),
        backgroundColor: bgcolor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: Text(
            "${completedList.length}/${widget.goals.length} Completed",
            style: TextStyle(fontSize: 12),
          )),
          const Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
              child: Text("In Progress",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Column(
              children: incompletedList
                  .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () => item.type == GoalType.progress
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ModifyProgressPage(
                                                goal: item as ProgressGoal,
                                                changeValGoal: refreshValue)))
                                : null,
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
                                          item.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        item.type == GoalType.progress
                                            ? progressBar(item as ProgressGoal)
                                            : todoBox(item as TodoGoal,
                                                refreshToggle, context),
                                      ],
                                    ),
                                  ),
                                ])),
                          ))))
                  .toList()),
          const Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
              child: Text("Completed",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Column(
              children: completedList
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () => item.type == GoalType.progress
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ModifyProgressPage(
                                                goal: item as ProgressGoal,
                                                changeValGoal: refreshValue)))
                                : null,
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
                                          item.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        item.type == GoalType.progress
                                            ? progressBar(item as ProgressGoal)
                                            : todoBox(item as TodoGoal,
                                                refreshToggle, context),
                                      ],
                                    ),
                                  ),
                                ])),
                          ),
                        ),
                      ))
                  .toList())
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add goal",
        backgroundColor: medgreen,
        onPressed: () async {
          var val = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateGoalPage(addGoalCallBack: widget.addGoal)));
          _updateGoalLists();
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
