import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:khaltabita/core/global_resources/constants.dart';

import 'core/app.dart';
import 'core/service_locator.dart';

void main() {
  Gemini.init(
    apiKey: AppConstants.giminiKey,
  );
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  runApp(const MyApp());
}
