import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:sizer/sizer.dart';

import '../../../core/router.dart';
import '../../../user/presentation/controller/app_cubit.dart';
import '../component/book_list_section.dart';
import '../controller/admin_cubit.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  void initState() {
    print(BlocProvider.of<AppCubit>(context).allBook);
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
              Expanded(child: UserListSection()),
              Expanded(child: BookListSection(numberOfElement: 10,allowPhysics: false,)),
            ],
          ),
        ),
      ),
    );
  }
}

class SummarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SummaryCard(
          title: 'All users',
          count: '2,300',
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

class UserListSection extends StatelessWidget {
  final List<Map<String, String>> users = [
    {"name": "Heba Ahmed", "email": "hebarasl@gmail.com"},
    {"name": "mohamed wael", "email": "mohamedwael808@gmail.com"},
    {"name": "mohamed alsharkay", "email": "mohamedalsharkay@gmail.com"},
    {"name": "salma", "email": "salma@gmail.com"},
    {"name": "mariam", "email": "maraim@gmail.com"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Users',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text("View all user")),
            ],
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 55.h,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserCard(
                  name: users[index]['name']!,
                  email: users[index]['email']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



class UserCard extends StatelessWidget {
  final String name;
  final String email;

  UserCard({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/user_avatar.png'),
        ),
        title: Text(name),
        subtitle: Text(email),
        trailing: PopupMenuButton<String>(
          onSelected: (String result) {
            switch (result) {
              case 'View user':
                Navigator.of(context).pushNamed(Routers.manageBook);
                break;
              case 'Delete user':

                BlocProvider.of<AdminCubit>(context).deleteBook();
                break;
            }
          },
          itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'View user',
              child: const Text('View user'),
            ),

            PopupMenuItem<String>(
              value: 'Delete user',
              child: const Text('Delete user'),
            ),
          ],
          icon: Image.asset(ImagePathManager.editIcon),
        ),
      ),
    );
  }
}
