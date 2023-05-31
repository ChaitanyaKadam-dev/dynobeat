import 'package:dynobeat/auth.dart';
import 'package:dynobeat/pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:dynobeat/pages/home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({required Key key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  get key => null;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            
            return LoginPage();
          }
        });
  }
}


