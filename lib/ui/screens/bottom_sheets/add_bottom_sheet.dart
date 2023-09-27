import 'package:flutter/material.dart';


import '../../utilities/app_colors.dart';
import '../../utilities/app_theme.dart';
import '../../widgets/my_text_field.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Add New task", textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,),
          const SizedBox(height: 16,),
          MyTextField(hintText: "Enter task title",),
          const SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description",),
          const SizedBox(height: 16,),
          Text("Select date",
              style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
          Text("24/9/2023",
              textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.normal,
                  color: AppColors.grey)),
          const Spacer(),
          ElevatedButton(onPressed: (){},
              child: const Text("Add"))
        ],
      ),
    );
  }
}
