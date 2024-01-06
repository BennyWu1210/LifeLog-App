
class Journal{
  final String title;
  final String content;
  final DateTime time;

  Journal({required this.title, required this.content, required this.time});

  /*
  Returns a json representation of the Journal object
   */
  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'content': content,
      'time': time.toIso8601String()
    };
  }

  /*
  Construct a Journal object from json
   */
  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
    title: json['title'],
    content: json['content'],
    time: DateTime.parse(json['time']),
  );
}

