import 'package:flutter/material.dart';
import 'package:sidebar_and_dashboard_ux/menu_dashboard_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuDashboardPage(),
    );
  }
}