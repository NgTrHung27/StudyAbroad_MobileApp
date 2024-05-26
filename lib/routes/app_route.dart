import 'package:flutter/material.dart';
import 'package:kltn_mobile/Model/user_login.dart';
import 'package:kltn_mobile/View/Authentication/forget_password.dart';
import 'package:kltn_mobile/View/Authentication/login_page.dart';
import 'package:kltn_mobile/View/Authentication/register_page.dart';
import 'package:kltn_mobile/View/HomePage/News/news_page.dart';
import 'package:kltn_mobile/View/HomePage/home_page.dart';
import 'package:kltn_mobile/View/Profile/user_detail.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case 'userdetail':
        final UserAuthLogin userAuth = routeSettings.arguments as UserAuthLogin;
        return MaterialPageRoute(
            builder: (_) => UserDetailsPage(userAuth: userAuth));
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/forgotpass':
        return MaterialPageRoute(builder: (_) => const ForgetPass());
      case '/news':
        return MaterialPageRoute(builder: (_) => const NewsPage(newsList: []));
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
