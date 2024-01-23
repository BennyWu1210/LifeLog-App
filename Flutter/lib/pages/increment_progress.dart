import 'package:flutter/material.dart';
import 'package:journal_app/style/style.dart';
import 'package:journal_app/utilities/goal_template.dart';

class ModifyProgressPage extends StatefulWidget {
  final ProgressGoal goal;
  final Function(ProgressGoal, int) changeValGoal;

  const ModifyProgressPage(
      {Key? key, required this.changeValGoal, required this.goal})
      : super(key: key);

  @override
  State<ModifyProgressPage> createState() => _ModifyProgressPageState();
}

class _ModifyProgressPageState extends State<ModifyProgressPage> {
  @override
  Widget build(BuildContext context) {
    // Add UI elements to increment/decrement progress and handle state changes
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify Progress'),
      ),
      body: widget.goal.total != 0
          ? Center(
              // Example UI elements
              child: Slider(
                activeColor: darkgreen,
                value: widget.goal.current.toDouble(),
                max: widget.goal.total.toDouble(),
                divisions: widget.goal.total,
                label: widget.goal.current.toString(),
                onChanged: (double value) {
                  widget.goal.current = value.toInt();
                  widget.changeValGoal(widget.goal, widget.goal.current);
                  setState(() {});
                },
              ),
            )
          : const Text("Error - Divide by 0"),
    );
  }
}
