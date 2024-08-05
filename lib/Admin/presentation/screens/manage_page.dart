import 'package:flutter/material.dart';

import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:sizer/sizer.dart';

import '../component/all_user_data.dart';
import '../component/book_list_section.dart';
import '../component/summary_data.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  void initState() {
    //print(BlocProvider.of<AppCubit>(context).allBook);
    //BlocProvider.of<AppCubit>(context).getBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundAdmin,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: AppBar(
          backgroundColor: ColorManager.backgroundAdmin,
          flexibleSpace: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                //height: 35.h,
                decoration: const BoxDecoration(
                  color: Color(0xFF964F24),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(170),
                    bottomLeft: Radius.circular(170),
                  ),
                ),
              ),
              Positioned(
                top: 15.h,
                child: const CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage('assets/book test.png'),
                ),
              ),
              Center(
                child: Text(
                  'Admin',
                  style: TextStyle(color: Colors.white, fontSize: 7.w),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: SizedBox(
          height: 150.h,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              SummarySection(),
              SizedBox(height: 7.h),
              const Expanded(child: UserListSection()),
              Expanded(
                  child: BookListSection(
                numberOfElement: 5,
                allowPhysics: false,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
