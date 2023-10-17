import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/providers/list_provider.dart';

import '../../../../../models/todo_data_model.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_theme.dart';
import '../../../bottom_sheets/bottom_sheet.dart';

class TodoWidget extends StatelessWidget {

  TodoDm todo;
  Function refreshList;
  int todoIndex;
  TodoWidget({super.key, required this.todo, required this.refreshList, required this.todoIndex});
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return InkWell(
      onTap: (){
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddBottomSheet(titleTextFieldText: todo.title, descriptionTextFieldText: todo.description, buttonText: "Update", documentId: todo.id, selectedTime: todo.date, ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
            color: AppColors.white),
        margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: .25,
            children: [
              SlidableAction(
                onPressed: (_){
                  refreshList(todo.id, todoIndex);
                },
                backgroundColor: Colors.red,
                foregroundColor: AppColors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            height: MediaQuery.of(context).size.height * .13,
            child: Row(
              children: [
                const VerticalDivider(),
                const SizedBox(width: 12,),
                 Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(todo.title, style: AppTheme.taskTitleTextStyle,),
                      Text(todo.description,
                        textAlign: TextAlign.start,
                        style: AppTheme.taskDescriptionTextStyle,)
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: const Icon(Icons.check, color: AppColors.white,))
              ],
            ),
          ),
        ),
      ),
    );
  }

}