import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/color_manager.dart';
import '../../../user/presentation/controller/app_cubit.dart';
import '../controller/admin_cubit.dart';

class SummarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SummaryCard(
          title: 'All users',
          count: '${BlocProvider.of<AdminCubit>(context).users.length}',
        ),
        SummaryCard(
          title: 'All Books',
          count: "${BlocProvider.of<AppCubit>(context).allBook.length}",
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String count;

  SummaryCard({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 43.w,
      height: 17.h,
      child: Card(
        color: ColorManager.boxesInAdmin,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 7.w,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.boxesInTextAdmin),
              ),
              Text(
                count,
                style: TextStyle(
                    fontSize: 8.w,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.boxesInTextAdmin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}