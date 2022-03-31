import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:insta_clone/logic/cubit/internet_cubit.dart';
import 'package:insta_clone/logic/cubit/settings_cubit.dart';
import 'package:path_provider/path_provider.dart';

import 'package:vk_sdk/vk_sdk.dart';

import 'package:insta_clone/presentation/router/app_router.dart';
import 'package:insta_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(
        appRouter: AppRouter(),
        connectivity: Connectivity(),
      ),
    ),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({Key? key, required this.appRouter, required this.connectivity})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<SettingsCubit>(
          create: (settingsCubitContext) => SettingsCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insta Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        onGenerateRoute: appRouter.onGenerateRoute,
        initialRoute: '/settings',
      ),
    );
  }
}

class VkLoginLayout extends StatefulWidget {
  final _plugin = VkSdk(debug: true);

  VkLoginLayout({Key? key}) : super(key: key);

  @override
  State<VkLoginLayout> createState() => _VkLoginLayoutState();
}

class _VkLoginLayoutState extends State<VkLoginLayout> {
  String? _sdkVersion;
  VKAccessToken? _token;
  VKUserProfile? _profile;
  String? _email;
  bool _sdkInitialized = false;

  @override
  void initState() {
    super.initState();

    _getSdkVersion();
    _initSdk();
  }

  @override
  Widget build(BuildContext context) {
    final token = _token;
    final profile = _profile;
    final isLogin = token != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login via VK example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
        child: Builder(
          builder: (context) => Center(
            child: Column(
              children: <Widget>[
                if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
                if (token != null && profile != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildUserInfo(context, profile, token, _email),
                  ),
                isLogin
                    ? OutlinedButton(
                        child: const Text('Log Out'),
                        onPressed: _onPressedLogOutButton,
                      )
                    : OutlinedButton(
                        child: const Text('Log In'),
                        onPressed: () => _onPressedLogInButton(context),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, VKUserProfile profile,
      VKAccessToken accessToken, String? email) {
    final photoUrl = profile.photo200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('User: '),
        Text(
          '${profile.firstName} ${profile.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Online: ${profile.online}, Online mobile: ${profile.onlineMobile}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (photoUrl != null) Image.network(photoUrl),
        const Text('AccessToken: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        const Text('Email: '),
        Text(
          accessToken.email ?? '',
          softWrap: true,
        ),
        Text('Created: ${accessToken.created}'),
        if (email != null) Text('Email: $email'),
      ],
    );
  }

  Future<void> _onPressedLogInButton(BuildContext context) async {
    final res = await widget._plugin.logIn(scope: [
      VKScope.email,
    ]);

    if (res.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log In failed: ${res.asError!.error}'),
        ),
      );
    } else {
      final loginResult = res.asValue!.value;
      if (!loginResult.isCanceled) await _updateLoginInfo();
    }
  }

  Future<void> _onPressedLogOutButton() async {
    await widget._plugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _initSdk() async {
    await widget._plugin.initSdk();
    _sdkInitialized = true;
    await _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await VkSdk.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateLoginInfo() async {
    if (!_sdkInitialized) return;

    final plugin = widget._plugin;
    final token = await plugin.accessToken;

    final profileRes = token != null ? await plugin.getUserProfile() : null;

    setState(() {
      _token = token;
      _profile = profileRes?.asValue?.value;
    });
  }
}
