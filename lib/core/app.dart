import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khaltabita/Admin/presentation/controller/admin_cubit.dart';
import 'package:khaltabita/core/router.dart';
import 'package:khaltabita/generated/l10n.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:khaltabita/user/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:khaltabita/user/presentation/screen/Gemini_chat.dart';
import 'package:khaltabita/user/presentation/screen/book_description.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../user/presentation/screen/Categories.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String? languageValue;
  // getDataLanguage()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   languageValue = prefs.getString("language");
  // }

  @override
  void initState() {
    //getDataLanguage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => AdminCubit(),
          ),
        ],
        child: BlocBuilder<AppCubit,AppState>(

          builder: (context ,state) {
            final appCubit = BlocProvider.of<AppCubit>(context);
            return MaterialApp(
              home:const GeminiChat(),
              locale: Locale(appCubit.languageValue ?? "ar"),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              // onGenerateRoute: RouteGenerator.getRoute,
              // initialRoute: Routers.geminiChat,
              debugShowCheckedModeBanner: false,

              //home: HomePage(),
            );
          }
        ),
      );
    });
  }
}
