import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/images_path.dart';
import '../../../core/router.dart';
import '../controller/admin_cubit.dart';
import '../screens/manage_page.dart';

class UseListForPage extends StatefulWidget {
  int numberOfElement;

  UseListForPage({super.key, required this.numberOfElement});

  @override
  State<UseListForPage> createState() => _UseListForPageState();
}

class _UseListForPageState extends State<UseListForPage> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _loadedUsers = [];
  int _currentMax = 0;

  @override
  void initState() {
    print(BlocProvider.of<AdminCubit>(context).users);
    print(widget.numberOfElement);
    super.initState();
    _loadMoreUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("iiiiiiiiiiiiiiiiiiii");
        _loadMoreUsers();
      }
    });
  }

  void _loadMoreUsers() {
    if (_currentMax >= widget.numberOfElement) return;
    setState(() {
      _currentMax = (_currentMax + 10) > widget.numberOfElement
          ? widget.numberOfElement
          : _currentMax + 10;
      _loadedUsers =
          BlocProvider.of<AdminCubit>(context).users.sublist(0, _currentMax);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: ListView(
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
          ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _loadedUsers.length,
            itemBuilder: (context, index) {
              return UserCard(
                name: _loadedUsers[index].userName,
                email: _loadedUsers[index].mail,
              );
            },
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String email;

  const UserCard({super.key, required this.name, required this.email});

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
