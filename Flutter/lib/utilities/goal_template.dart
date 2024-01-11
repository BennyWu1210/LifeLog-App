enum GoalType { todo, progress }

class Goal {
  final String title;
  bool completed;
  GoalType type;

  Goal({required this.title, required this.completed, required this.type});

  Map<String, dynamic> toJson(){
    return {};
  }

  factory Goal.fromJson(Map<String, dynamic> json){
    switch (json['type']){
      case 'todo':
        return TodoGoal.fromJson(json);
      case 'progress':
        return ProgressGoal.fromJson(json);
      default:
        throw Exception('Unknown goal type');
    }
  }
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

  @override
  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'completed': completed,
      'state': state,
      'type': 'todo'
    };
  }

  factory TodoGoal.fromJson(Map<String, dynamic> json){
    return TodoGoal(
      title: json['title'],
      state: json['state'],
      type: GoalType.todo,
      completed: json['completed']
    );
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

  @override
  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'completed': completed,
      'current': current,
      'total': total,
      'type': 'progress'
    };
  }

  factory ProgressGoal.fromJson(Map<String, dynamic> json){
    return ProgressGoal(
      title: json['title'],
      total: json['total'],
      type: GoalType.progress,
      completed: json['completed'],
      current: json['current']
    );
  }
}

