import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/providers/list_provider.dart';
import 'package:todo_app/ui/screens/home/tabs/list/todo_widget.dart';
import '../../../../utilities/app_colors.dart';

class ListTab extends StatefulWidget {

  ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      provider.refreshTodosList();
    } );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
   //  if(provider.todos.isEmpty){
   //   provider.refreshTodosList();
   //   print("z");
   // }
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .12,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(color: AppColors.primary,)),
                  Expanded(
                      flex: 7,
                      child: Container(color: AppColors.accent,))
                ],
              ),
              CalendarTimeline(
                initialDate: provider.selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date){
                  provider.selectedDate = date;
                  provider.refreshTodosList();
                },
                leftMargin: 20,
                monthColor: AppColors.white,
                dayColor: AppColors.primary,
                activeDayColor: AppColors.primary,
                activeBackgroundDayColor: AppColors.white,
                dotsColor: AppColors.transparent,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todos.length, itemBuilder: (context, index) => TodoWidget(todoIndex: index, refreshList: deleteSpecificTask, todo: provider.todos[index],)),
        ),
      ],
    );
  }

  void deleteSpecificTask(String todoId, int todoIndex){
    provider.deleteTodoWidget(todoId, todoIndex);
  }

}
