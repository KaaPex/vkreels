import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/core/constants/enums.dart';
import 'package:vk_reels/core/themes/app_theme.dart';
import 'package:vk_reels/logic/bloc/authentication/authentication_bloc.dart';
import 'package:vk_reels/logic/cubit/internet_cubit.dart';
import 'package:vk_reels/logic/cubit/settings_cubit.dart';
import 'package:vk_reels/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'data/repository/vk_sdk_repository.dart';
import 'presentation/screens/screens.dart';

class App extends StatelessWidget {
  final Connectivity connectivity;
  final VkSdkRepository vkSdkRepository;

  const App({Key? key, required this.connectivity, required this.vkSdkRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: vkSdkRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (internetCubitContext) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (settingsCubitContext) => AuthenticationBloc(vkSdkRepository: vkSdkRepository),
          ),
          BlocProvider<SettingsCubit>(
            create: (settingsCubitContext) => SettingsCubit(),
          )
        ],
        child: AppView(appRouter: AppRouter()),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  final AppRouter appRouter;

  const AppView({Key? key, required this.appRouter}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previousState, state) {
        // rebuild if only theme or locale settings is changed
        return previousState.appDarkMode != state.appDarkMode || previousState.locale != state.locale;
      },
      builder: (_, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VK Reels',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.appDarkMode ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('ru', ''), // Russian, no country code
          ],
          locale: state.locale,
          onGenerateRoute: widget.appRouter.onGenerateRoute,
          initialRoute: AppRouter.logo,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      MainScreen.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginScreen.route(),
                      (route) => false,
                    );
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
