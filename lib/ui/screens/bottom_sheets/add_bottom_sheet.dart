import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/providers/list_provider.dart';


import '../../utilities/app_colors.dart';
import '../../utilities/app_theme.dart';
import '../../widgets/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {

  AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  DateTime selectedTime  = DateTime.now();
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
          const Text("Add New task", textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,),
          const SizedBox(height: 16,),
          MyTextField(hintText: "Enter task title", textfieldController: taskName),
          const SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description", textfieldController: taskDescription,),
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
            addToFireStore();
          },
              child: const Text("Add"))
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

}
