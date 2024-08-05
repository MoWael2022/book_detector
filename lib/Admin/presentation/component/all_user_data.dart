import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/images_path.dart';
import '../../../core/router.dart';
import '../controller/admin_cubit.dart';
import '../screens/manage_page.dart';

class UserListSection extends StatelessWidget {
  const UserListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: FutureBuilder(
          future: BlocProvider.of<AdminCubit>(context).viewAllUser(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Users',
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routers.allAdminUser);
                          }, child: const Text("View all user")),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    height: 55.h,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                      BlocProvider.of<AdminCubit>(context).users.length > 5 ? 5 : BlocProvider.of<AdminCubit>(context).users.length,
                      itemBuilder: (context, index) {
                        return UserCard(
                          name: BlocProvider.of<AdminCubit>(context).users[index].userName,
                          email:BlocProvider.of<AdminCubit>(context).users[index].mail,
                        );
                      },
                    ),
                  ),
                ],
              );
            }else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          }),
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
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'View user',
              child: Text('View user'),
            ),
            const PopupMenuItem<String>(
              value: 'Delete user',
              child: Text('Delete user'),
            ),
          ],
          icon: Image.asset(ImagePathManager.editIcon),
        ),
      ),
    );
  }
}