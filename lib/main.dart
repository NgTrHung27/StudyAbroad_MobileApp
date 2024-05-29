import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/auth/auth_cubit.dart';
import 'package:kltn_mobile/bloC/auth/forgot_pass_cubit.dart';
import 'package:kltn_mobile/bloC/auth/login_cubit.dart';
import 'package:kltn_mobile/bloC/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/bloC/news/news_cubit.dart';
import 'package:kltn_mobile/bloC/profile_status/profile_status_cubit.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';
import 'package:kltn_mobile/bloC/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/routes/app_route.dart';

void main() {
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingCubit, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state,
          themeMode: ThemeMode.system,
          initialRoute: "/",
          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      },
    );
  }
}
