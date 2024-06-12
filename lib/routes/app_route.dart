import 'package:flutter/material.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/screens/authentication/forget_password.dart';
import 'package:kltn_mobile/screens/authentication/login_page.dart';
import 'package:kltn_mobile/screens/authentication/logout.dart';
import 'package:kltn_mobile/screens/authentication/register_page.dart';
import 'package:kltn_mobile/screens/home/contact_us.dart';
import 'package:kltn_mobile/screens/home/home_page.dart';

import 'package:kltn_mobile/screens/home/splash.dart';
import 'package:kltn_mobile/screens/mainpage/mainpage.dart';
import 'package:kltn_mobile/screens/news/news_page.dart';
import 'package:kltn_mobile/screens/profiles/user.dart';
import 'package:kltn_mobile/screens/profiles/user_detail.dart';

import '../screens/notifications/notifications_page.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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
      case '/contactus':
        return MaterialPageRoute(builder: (_) => const ContactUs());
      case '/mainpage':
        return MaterialPageRoute(builder: (_) => const MainPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
