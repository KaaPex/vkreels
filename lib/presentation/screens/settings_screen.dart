import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          width: double.infinity,
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (settingsCubitContext, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SwitchListTile(
                    title: const Text('App Notifications'),
                    value: state.appNotifications,
                    onChanged: (bool value) {
                      settingsCubitContext
                          .read<SettingsCubit>()
                          .setAppNotification(value);
                    },
                    secondary: const Icon(Icons.lightbulb_outline),
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
