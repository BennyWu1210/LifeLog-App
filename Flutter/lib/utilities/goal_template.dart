enum GoalType { todo, progress }

class Goal {
  final String title;
  bool completed;
  GoalType type;

  Goal({required this.title, required this.completed, required this.type});
}

class TodoGoal extends Goal {
  bool state;

  TodoGoal(
      {required super.title,
      required this.state,
      super.type = GoalType.todo,
      super.completed = false});

  void toggleState() {
    state = !state;
    completed = state == true;
  }
}

class ProgressGoal extends Goal {
  int current;
  final int total;

  ProgressGoal(
      {required super.title,
      this.current = 0,
      required this.total,
      super.type = GoalType.progress,
      super.completed = false});
}
