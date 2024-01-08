import 'package:flutter/material.dart';
import 'package:journal_app/pages/goal_page.dart';
import '../utilities/goal_template.dart';
import '../style/style.dart';

Widget progressBar(ProgressGoal goal) {
  return Flexible(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(160, 11, 40, 0),
      child: LinearProgressIndicator(
        minHeight: 5,
        borderRadius: BorderRadius.circular(100),
        color: darkgreen,
        backgroundColor: Colors.white.withOpacity(0.85),
        value: goal.current.toDouble() / goal.total,
      ),
    ),
  );
}

Widget todoBox(TodoGoal goal, Function(TodoGoal) toggleGoal) {
  // very inefficient but whatever
  return Padding(
    padding: const EdgeInsets.fromLTRB(270, 0, 20, 0),
    child: Checkbox(
      side: BorderSide.none,
      value: goal.state,
      fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) =>
              goal.state ? darkgreen : Colors.white.withOpacity(0.85)),
      onChanged: (bool? value) {
        toggleGoal(goal);
      },
    ),
  );
}

class GoalsOverview extends StatelessWidget {
  final List<Goal> goals;
  final Function(Goal) addGoal;
  final Function(int) removeGoal;
  final Function(TodoGoal) toggleGoal;

  const GoalsOverview({
    Key? key,
    required this.goals,
    required this.addGoal,
    required this.removeGoal,
    required this.toggleGoal,
  }) : super(key: key);

  @override
  Widget build(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: lightgreen,
        height: 170, // hardcode gang
        width: MediaQuery.of(context).size.width,
        child: goals.length >= 3
            ? Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  margin: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                  child: Stack(
                    children: [
                      Text(
                        goals[0].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      goals[0].type == GoalType.progress
                          ? progressBar(goals[0] as ProgressGoal)
                          : todoBox(goals[0] as TodoGoal, toggleGoal),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Stack(
                    children: [
                      Text(
                        goals[1].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      goals[1].type == GoalType.progress
                          ? progressBar(goals[1] as ProgressGoal)
                          : todoBox(goals[1] as TodoGoal, toggleGoal),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Stack(
                    children: [
                      Text(
                        goals[2].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      goals[2].type == GoalType.progress
                          ? progressBar(goals[2] as ProgressGoal)
                          : todoBox(goals[2] as TodoGoal, toggleGoal),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalPage(
                              goals: goals,
                              addGoal: addGoal,
                              removeGoal: removeGoal,
                              toggleGoal: toggleGoal,
                            ),
                          )),
                      child: const Text(
                        "3 / 8 goals completed >",
                        style: TextStyle(
                            color: darkgreen, fontWeight: FontWeight.bold),
                      )),
                )
              ])
            : Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalPage(
                            goals: goals,
                            addGoal: addGoal,
                            removeGoal: removeGoal,
                            toggleGoal: toggleGoal,
                          ),
                        )),
                    child: const Text(
                      "3 / 8 goals completed >",
                      style: TextStyle(
                          color: darkgreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ), // hardcode gang
      ),
    );
  }
}
