import 'package:flutter/material.dart';
import 'package:kltn_mobile/screens/authentication/forget_password.dart';
import 'package:kltn_mobile/screens/authentication/login_page.dart';
import 'package:kltn_mobile/screens/authentication/logout.dart';
import 'package:kltn_mobile/screens/authentication/register_page.dart';
import 'package:kltn_mobile/screens/home/contact_us.dart';
import 'package:kltn_mobile/screens/home/home_page.dart';

import 'package:kltn_mobile/screens/home/splash.dart';
import 'package:kltn_mobile/screens/home/mainpage.dart';
import 'package:kltn_mobile/screens/news/news_page.dart';
import 'package:kltn_mobile/screens/profiles/profile.dart';
import 'package:kltn_mobile/screens/profiles/profile_detail.dart';
import 'package:kltn_mobile/screens/profiles/profile_status.dart';

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
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/forgotpass':
        return MaterialPageRoute(builder: (_) => const ForgetPass());
      case '/logout':
        return MaterialPageRoute(builder: (_) => const LogoutPage());
      case '/news':
        return MaterialPageRoute(builder: (_) => const NewsPage(newsList: []));
      case '/profile':
        return MaterialPageRoute(builder: (_) => const Profile());
      case '/profiledetail':
        return MaterialPageRoute(builder: (_) => const ProfileDetail());
      case '/profilestatus':
        return MaterialPageRoute(builder: (_) => const ProfileStatus());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      case '/contactus':
        return MaterialPageRoute(builder: (_) => const ContactUs());
      case '/mainpage':
        return MaterialPageRoute(builder: (_) => const MainPage());
      default:
        return MaterialPageRoute(builder: (_) => const MainPage());
    }
  }
}
