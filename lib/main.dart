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
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/routes/app_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        BlocProvider(create: (_) => LanguageBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
