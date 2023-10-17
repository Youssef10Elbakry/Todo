import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/providers/list_provider.dart';


import '../../utilities/app_colors.dart';
import '../../utilities/app_theme.dart';
import '../../widgets/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {
  String titleTextFieldText;
  String descriptionTextFieldText;
  String buttonText;
  String documentId;
  DateTime selectedTime;
  AddBottomSheet({super.key, required this.titleTextFieldText, required this.descriptionTextFieldText, required this.buttonText, required this.documentId, required this.selectedTime});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState(titleTextFieldText: titleTextFieldText, descriptionTextFieldText:  descriptionTextFieldText, buttonText: buttonText, documentId: documentId, selectedTime: selectedTime);
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  DateTime selectedTime;
  String titleTextFieldText;
  String descriptionTextFieldText;
  String buttonText;
  String documentId;
  _AddBottomSheetState({required this.titleTextFieldText, required this.descriptionTextFieldText, required this.buttonText, required this.documentId, required this.selectedTime });

  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(buttonText == "Add"? "Add New Task": "Edit Task", textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,),
          const SizedBox(height: 16,),
          MyTextField(hintText: "Enter task title", textfieldController: taskName, intitalizingText: titleTextFieldText,),
          const SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description", textfieldController: taskDescription, intitalizingText: descriptionTextFieldText,),
          const SizedBox(height: 16,),
          Text("Select date",
              style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
          InkWell(
            onTap: (){
              showMyDatePicker();
            },
            child: Text("${selectedTime.day}/${selectedTime.month}/${selectedTime.year}",
                textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.normal,
                    color: AppColors.grey)),
          ),
          const Spacer(),
          ElevatedButton(onPressed: (){
            buttonText == "Add"? addToFireStore():editTodo(documentId) ;
          },
              child: Text(buttonText))
        ],
      ),
    );
  }

  showMyDatePicker() async{
    selectedTime = await showDatePicker(context: context,
        initialDate: selectedTime,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))
    ) ?? DateTime.now();
    setState(() {});
  }

  void addToFireStore(){
    CollectionReference todosCollection =
    FirebaseFirestore.instance.collection("todos");    //creates new collection

    DocumentReference newDoc = todosCollection.doc(); //creates new empty document in the collection
    newDoc.set(
        {
          "id": newDoc.id,
          "title": taskName.text,
          "description": taskDescription.text,
          "date": selectedTime,
          "isDone": false
        }
    ).timeout(const Duration(milliseconds: 300), onTimeout: (){
      provider.refreshTodosList();
     Navigator.pop(context);
    }
    );
  }

  void editTodo(String todoToUpdateId){
    CollectionReference todosCollection = FirebaseFirestore.instance.collection("todos");
    DocumentReference docToEdit = todosCollection.doc(todoToUpdateId);
    docToEdit.set(
      {
        "id": docToEdit.id,
        "title": taskName.text,
        "description": taskDescription.text,
        "date": selectedTime,
        "isDone": false
      }
    ).timeout(const Duration(milliseconds: 300), onTimeout: (){
      Navigator.pop(context);
    });
  }

}
