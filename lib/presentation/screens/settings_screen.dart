import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/logic/cubit/settings_cubit.dart';

import '../../core/constants/colors.dart';
import '../../logic/bloc/bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (settingsCubitContext, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          t.settingsAppLanguage,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                      ),
                      DropdownButton(
                        value: state.locale.languageCode,
                        items: [
                          DropdownMenuItem(
                            child: Text(t.settingsInputLanguage('en')),
                            value: 'en',
                          ),
                          DropdownMenuItem(
                            child: Text(t.settingsInputLanguage('ru')),
                            value: 'ru',
                          ),
                        ],
                        onChanged: (String? value) => settingsCubitContext.read<SettingsCubit>().setAppLocale(value!),
                      ),
                    ],
                  ),
                  SwitchListTile(
                    title: Text(
                      t.settingsAppDarkMode,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    value: state.appDarkMode,
                    onChanged: (bool value) => settingsCubitContext.read<SettingsCubit>().setAppDarkMode(value),
                    // secondary: const Icon(Icons.lightbulb_outline),
                  ),
                  SwitchListTile(
                    title: Text(
                      t.settingsAppNotification,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    value: state.appNotifications,
                    onChanged: (bool value) => settingsCubitContext.read<SettingsCubit>().setAppNotification(value),
                    // secondary: const Icon(Icons.lightbulb_outline),
                  ),
                  // Flexible(
                  //   child: Container(),
                  //   flex: 1,
                  // ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          context.read<LoginBloc>().add(const LogoutButtonPressed());
                        },
                        child: Container(
                          child: Text(t.logout),
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            color: blueColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
