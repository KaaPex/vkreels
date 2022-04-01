import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;

    return Scaffold(
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
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
