import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'utils/color_utils.dart';
import 'utils/urlhandling/configure_nonweb.dart'
    if (dart.library.html) 'utils/urlhandling/configure_web.dart';

void main() {
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uxquran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryWhite,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UxDashboardScreen(),
    );
  }
}
