import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/todo_data_model.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDm> todos = [];
  DateTime selectedDate = DateTime.now();
  int alreadyAdded = 0;
  bool isTodoWidgetVisible = true;
  Map todoJson = {};
  List<bool> areTodosVisible = [];


  void refreshTodosList() async{
    CollectionReference todosCollection = FirebaseFirestore.instance.collection("todos");
    QuerySnapshot todosSnapShot = await todosCollection.orderBy("date").get();
    List<QueryDocumentSnapshot> todosDocs = todosSnapShot.docs;
    print(todosDocs.length);
    for(int i = todos.length; i<todosDocs.length; i++){
        todoJson = todosDocs[i].data() as Map;
        todos.add(TodoDm.fromJson(todoJson));
        areTodosVisible.add(true);
    }
    todos = todos.where((todo){
      if (todo.date.day != selectedDate.day ||
          todo.date.month != selectedDate.month ||
          todo.date.year != selectedDate.year) {
        return false;
      }
      else{
        return true;
      }
    } ).toList();
    for(int i = 0; i<todos.length; i++){
      print(todos[i].title);
    }

    notifyListeners();
  }


  void deleteTodoWidget(String todoToDeleteId, int todoToDeleteIndex){
    todos.removeAt(todoToDeleteIndex);
    FirebaseFirestore.instance.collection("todos").doc(todoToDeleteId).delete();
    notifyListeners();
  }
}