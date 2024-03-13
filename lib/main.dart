import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  runApp(const MyApp());
}

