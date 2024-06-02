import 'package:flutter/material.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/screens/Authentication/forget_password.dart';
import 'package:kltn_mobile/screens/Authentication/login_page.dart';
import 'package:kltn_mobile/screens/Authentication/logout.dart';
import 'package:kltn_mobile/screens/Authentication/register_page.dart';
import 'package:kltn_mobile/screens/home/home_page.dart';

import 'package:kltn_mobile/screens/home/splash.dart';
import 'package:kltn_mobile/screens/news/news_page.dart';
import 'package:kltn_mobile/screens/profiles/user.dart';
import 'package:kltn_mobile/screens/profiles/user_detail.dart';

import '../screens/notifications/notifications_page.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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
      case '/logout':
        return MaterialPageRoute(builder: (_) => const LogoutPage());
      case '/news':
        return MaterialPageRoute(builder: (_) => const NewsPage(newsList: []));
      case '/user':
        return MaterialPageRoute(builder: (_) => const UserProfile());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
