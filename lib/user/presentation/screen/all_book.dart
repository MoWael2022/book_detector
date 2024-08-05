import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/Admin/presentation/component/all_book_data.dart';
import 'package:khaltabita/Admin/presentation/component/book_list_section.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';

class AllBookUserPage extends StatelessWidget {
  const AllBookUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: AllBookData(
        editing: false,
        allowPhysics: true,
        numberOfElement: BlocProvider.of<AppCubit>(context).allBook.length,
      ),
    );
  }
}
