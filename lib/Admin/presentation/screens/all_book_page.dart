import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/Admin/presentation/component/all_book_data.dart';
import 'package:khaltabita/Admin/presentation/component/book_list_section.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';

class AllBookAdminPage extends StatelessWidget {
  const AllBookAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: AllBookData(
        editing: true,
        allowPhysics: true,
        numberOfElement: BlocProvider.of<AppCubit>(context).allBook.length,
      ),
    );
  }
}
