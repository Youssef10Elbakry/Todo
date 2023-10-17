import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/home/tabs/list/list_tab.dart';
import 'package:todo_app/ui/screens/home/tabs/settings/settings_tab.dart';

import '../bottom_sheets/bottom_sheet.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNav(),
      body: currentSelectedTabIndex == 0 ? ListTab() : const SettingsTab(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildFab() =>
      FloatingActionButton(onPressed: (){
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddBottomSheet(titleTextFieldText: "", descriptionTextFieldText: "", buttonText: "Add", documentId: "", selectedTime: DateTime.now(),),
            ));
      },
        child: const Icon(Icons.add),);

  Widget buildBottomNav() =>
      BottomAppBar( // This class is used to control the interaction between a nav. bar and a floating button
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.hardEdge,  //To cut a part of the nav. bar to take the circular shape of the floating button
        child: BottomNavigationBar(
            onTap: (index){
              currentSelectedTabIndex = index;
              setState(() {});
            },
            currentIndex: currentSelectedTabIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ]),
      );

  PreferredSizeWidget buildAppBar() => AppBar(
    title: const Text("To Do List"),
    toolbarHeight: MediaQuery.of(context).size.height * .1,
  );
}