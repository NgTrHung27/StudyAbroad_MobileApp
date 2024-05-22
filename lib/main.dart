import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/View/Authentication/login_page.dart';
import 'package:kltn_mobile/View/Authentication/register_page.dart';
import 'package:kltn_mobile/View/HomePage/News/news_page.dart';
import 'package:kltn_mobile/View/HomePage/home_page.dart';
import 'package:kltn_mobile/bloC/auth/auth_cubit.dart';
import 'package:kltn_mobile/bloC/auth/forgot_pass_cubit.dart';
import 'package:kltn_mobile/bloC/auth/login_cubit.dart';
import 'package:kltn_mobile/bloC/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/bloC/profile_status/profile_status_cubit.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';
import 'package:kltn_mobile/bloC/theme_setting_cubit/theme_setting_cubit.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LoginCubit(APIRepository())),
        BlocProvider(create: (_) => ProfileStatusCubit()),
        BlocProvider(create: (_) => ForgotPassCubit(APIRepository())),
        BlocProvider(
            create: (context) =>
                CarouselBloc(APIRepository())..add(FetchCarousel())),
        BlocProvider(create: (context) => ThemeSettingCubit()),
      ],
      child: BlocBuilder<ThemeSettingCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state,
              themeMode: ThemeMode.system,
              home: const HomePage());
        },
      ),
    );
  }
}
