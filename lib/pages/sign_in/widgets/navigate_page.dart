// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({required this.child});
  final Widget child;

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  late TextEditingController _textEditingController;
  int _currentRoute = 0;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xffe0e9f8),
                title: widget.child,
                centerTitle: true,
              ),
            );
          });
    });
  }
}
