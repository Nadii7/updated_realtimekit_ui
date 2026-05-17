import 'package:flutter/material.dart';

class RtkRouter {
  static RtkRouterDelegate of(BuildContext context) =>
      RtkRouterDelegate(context);
}

class RtkRouterDelegate {
  final BuildContext context;
  RtkRouterDelegate(this.context);

  void pop() => Navigator.pop(context);

  void pushReplacementNamed(String pageName, [dynamic extra]) {
    Navigator.pushReplacementNamed(context, pageName, arguments: extra);
  }

  void pushNamed(String pageName, [dynamic extra]) {
    Navigator.pushNamed(context, pageName, arguments: extra);
  }

  void push(Widget page, {String? pageName}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: pageName != null ? RouteSettings(name: pageName) : null,
      ),
    );
  }
}
