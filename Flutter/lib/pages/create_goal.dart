import 'package:flutter/material.dart';
import 'package:journal_app/utilities/goal_template.dart';
import '../utilities/journal_template.dart';
import '../style/style.dart';

class CreateGoalPage extends StatefulWidget {
  final Function(Goal) addGoalCallBack;

  const CreateGoalPage({Key? key, required this.addGoalCallBack})
      : super(key: key);

  @override
  State<CreateGoalPage> createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends State<CreateGoalPage> {
  final goalTitleController =
      TextEditingController(); // TODO: check maximum words
  final totalNumberController =
      TextEditingController(); // Controller for total number

  GoalType selectedGoalType = GoalType.progress;

  /*
  This popup shows when the user leaves the title or content blank
   */
  Widget popup(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Please do not leave the title blank & enter valid number",
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
          'New Goal',
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
                    labelText: "Goal Title",
                    border: InputBorder.none,
                    hintText: "What's going on in your life?",
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    labelStyle: Theme.of(context).textTheme.headlineSmall),
                style: Theme.of(context).textTheme.headlineSmall,
                controller: goalTitleController,
              ),
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Select Goal Type",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 140,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedGoalType = GoalType.progress;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: selectedGoalType == GoalType.progress
                                ? Colors.black45
                                : Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: selectedGoalType == GoalType.progress
                              ? medgreen
                              : null),
                      child: Text(
                        "Progress Goal",
                        style: TextStyle(
                            fontWeight: selectedGoalType == GoalType.progress
                                ? FontWeight.bold
                                : null,
                            color: selectedGoalType == GoalType.progress
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  SizedBox(
                    width: 140,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedGoalType = GoalType.todo;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: selectedGoalType == GoalType.todo
                                ? Colors.black45
                                : Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: selectedGoalType == GoalType.todo
                              ? medgreen
                              : null),
                      child: Text(
                        "Todo Goal",
                        style: TextStyle(
                            fontWeight: selectedGoalType == GoalType.todo
                                ? FontWeight.bold
                                : null,
                            color: selectedGoalType == GoalType.todo
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                  // Conditional rendering of the TextField for total number
                ],
              ),
            ),
            if (selectedGoalType == GoalType.progress)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  controller: totalNumberController,
                  keyboardType: TextInputType.number, // Ensures numeric input
                  decoration: InputDecoration(
                    labelText: 'Total',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: lightgreen, width: 1.0)),
                    hintText: 'Enter a number',
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*
          Post journal
           */
            if (goalTitleController.text != "") {
              if (selectedGoalType == GoalType.progress) {
                try {
                  int number = int.parse(totalNumberController.text);
                  if (number <= 0) throw Exception("Cannot divide by 0");

                  widget.addGoalCallBack(ProgressGoal(
                      title: goalTitleController.text, total: number));
                  setState(() {});
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => popup(context));
                }
              } else {
                widget.addGoalCallBack(
                    TodoGoal(title: goalTitleController.text, state: false));
              }
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
