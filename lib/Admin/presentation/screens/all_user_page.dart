import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/all_user_data.dart';
import '../component/user_llst_section.dart';
import '../controller/admin_cubit.dart';

class AllUser extends StatelessWidget {
  const AllUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UseListForPage(
      numberOfElement: BlocProvider.of<AdminCubit>(context).users.length,
    );
  }
}
