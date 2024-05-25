import 'package:flutter/cupertino.dart';
import 'package:sidneys_github_explorer/ux/views/login/login_page.dart';

class Navigation {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String entry = "entry";
  static const String homeScreen = "homescreen";


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case entry:
        return CupertinoPageRoute(
          builder: (_) => const LoginPage(),
        );
      case homeScreen:
        return CupertinoPageRoute(
          builder: (_) => Container(),
        );

      default:
        return CupertinoPageRoute(
          builder: (_) => Container(),
        );
    }
  }

}