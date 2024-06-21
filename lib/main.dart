import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/auth_cubit.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/forgot_pass_cubit.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/login_cubit.dart';
import 'package:kltn_mobile/blocs/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/news_cubit_bloc/news_cubit.dart';
import 'package:kltn_mobile/blocs/profile_status_cubit_bloc/profile_status_cubit.dart';
import 'package:kltn_mobile/blocs/repository/repository.dart';
import 'package:kltn_mobile/blocs/schools_cubit/schools_cubit.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/routes/app_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/authentication/auth_notify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userAuth = await checkLoginStatus();
  final isLoggedIn = userAuth != null;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeSettingCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LoginCubit(APIRepository())),
        BlocProvider(create: (_) => ProfileStatusCubit()),
        BlocProvider(create: (_) => ForgotPassCubit(APIRepository())),
        BlocProvider(
            create: (context) =>
                CarouselBloc(APIRepository())..add(FetchCarousel())),
        BlocProvider(create: (_) => NewsCubit()),
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => SchoolsCubit()),
        ChangeNotifierProvider(
            create: (_) => AuthNotifier()..setLoggedIn(isLoggedIn)),
      ],
      child: MyApp(userAuth: userAuth),
    ),
  );
}

Future<UserAuthLogin?> checkLoginStatus() async {
  final logindata = await SharedPreferences.getInstance();
  final userString = logindata.getString('user');
  if (userString != null) {
    final user = UserAuthLogin.fromJson(jsonDecode(userString));
    return user;
  } else {
    return null;
  }
}

class MyApp extends StatefulWidget {
  final UserAuthLogin? userAuth;
  @override
  State<MyApp> createState() => _MyAppState();
  const MyApp({super.key, this.userAuth});
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeSettingCubit, ThemeData>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state,
              themeMode: ThemeMode.system,
              initialRoute: "/",
              onGenerateRoute: AppRoute.onGenerateRoute,
              supportedLocales: const [
                Locale('en'), // English
                Locale('ko'), // Korean
                Locale('vi') // Vietnamese
              ],
              //Language
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: locale,
            );
          },
        );
      },
    );
  }
}
