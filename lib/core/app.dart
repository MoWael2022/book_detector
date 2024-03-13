import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/router.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/user/presentation/screen/book_description.dart';
import 'package:sizer/sizer.dart';

import '../user/presentation/screen/home.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => AppCubit(),
        child:const MaterialApp(
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routers.homePage,
          debugShowCheckedModeBanner: false,
          //home: HomePage(),
        ),
      );
    });
  }
}
