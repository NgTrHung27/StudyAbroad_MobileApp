import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/auth_cubit.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/forgot_pass_cubit.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/login_cubit.dart';
import 'package:kltn_mobile/blocs/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/blocs/contact_us_bloc/contact_cubit.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/news_cubit_bloc/news_cubit.dart';
import 'package:kltn_mobile/blocs/profile_status_cubit_bloc/profile_status_cubit.dart';
import 'package:kltn_mobile/blocs/repository/repository.dart';
import 'package:kltn_mobile/blocs/schools_cubit/schools_cubit.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/notifications/firebase_api.dart';
import 'package:kltn_mobile/components/notifications/noti_services.dart';
import 'package:kltn_mobile/firebase_options.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/routes/app_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/Authentication/auth_data_notify.dart';
import 'package:kltn_mobile/screens/authentication/auth_notify.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
//Main
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//FirebaseMess
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Kiểm tra nếu đang chạy trên Android
  bool isRunningOnAndroid = Platform.isAndroid;

  // Chỉ thực thi phần thông báo nếu đang chạy trên Android
  if (isRunningOnAndroid) {
    await FirebaseApi().initNotifications();
    await initializeNotifications();
    await setupNotificationChannel();
    await listenToForegroundMessages();
    setupFirebaseMessagingBackgroundHandler();
  }
  // Kiểm tra session đăng nhập
  final loginCubit = LoginCubit(APIRepository());
  final userAuth = await loginCubit.checkLoginStatus();
  final isLoggedIn = userAuth != null;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeSettingCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(
            create: (_) => loginCubit), // Sử dụng loginCubit đã khởi tạo
        BlocProvider(create: (_) => ProfileStatusCubit()),
        BlocProvider(create: (_) => ForgotPassCubit(APIRepository())),
        BlocProvider(
            create: (context) =>
                CarouselBloc(APIRepository())..add(FetchCarousel())),
        BlocProvider(create: (_) => NewsCubit()),
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => SchoolsCubit()),
        BlocProvider(create: (_) => ContactUsCubit(APIRepository())),
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),

        ChangeNotifierProvider(
            create: (_) => AuthNotifier()..setLoggedIn(isLoggedIn)),
      ],
      child: MyApp(userAuth: userAuth),
    ),
  );
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
    context.read<LoginCubit>().checkLoginStatus();
    listenToForegroundMessages();
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
              navigatorKey: navigatorKey,
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
