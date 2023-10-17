import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDm{
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;
  TodoDm({required this.id, required this.title, required this.description, required this.date, required this.isDone});
  TodoDm.fromJson(Map json){
    id = json["id"];
    title = json["title"];
    description = json["description"];
    Timestamp time =  json["date"];
    date = time.toDate();
    isDone = json["isDone"];
  }
}