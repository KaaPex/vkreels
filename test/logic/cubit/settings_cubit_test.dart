import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:vk_reels/logic/cubit/settings_cubit.dart';

import '../../helpers/hydrated_bloc.dart';

void main() {
  group('SettingsCubit', () {
    setUp(() {});

    test('initial state is SettingsState(Locale("en"), true, true)', () {
      mockHydratedStorage(() {
        expect(SettingsCubit().state, const SettingsState(Locale('en'), true, true));
      });
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        mockHydratedStorage(() {
          final settingsCubit = SettingsCubit();
          expect(
            settingsCubit.fromJson(settingsCubit.toJson(settingsCubit.state)),
            settingsCubit.state,
          );
        });
      });
    });

    group('updateSettings', () {
      blocTest<SettingsCubit, SettingsState>(
        'emits locale "ru" for SettingsState.locale',
        build: () => mockHydratedStorage(SettingsCubit.new),
        act: (cubit) => cubit.setAppLocale('ru'),
        expect: () => [const SettingsState(Locale('ru'), true, true)],
      );

      blocTest<SettingsCubit, SettingsState>(
        'emits light mode for SettingsState.appDarkMode',
        build: () => mockHydratedStorage(SettingsCubit.new),
        act: (cubit) => cubit.setAppDarkMode(false),
        expect: () => [const SettingsState(Locale('en'), false, true)],
      );

      blocTest<SettingsCubit, SettingsState>(
        'emits decline notifications for SettingsState.appNotifications',
        build: () => mockHydratedStorage(SettingsCubit.new),
        act: (cubit) => cubit.setAppNotification(false),
        expect: () => [const SettingsState(Locale('en'), true, false)],
      );
    });
  });
}
