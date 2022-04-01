import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(Locale('en'), true, true));

  @override
  SettingsState fromJson(Map<String, dynamic> json) => SettingsState(
        Locale(json['locale'] as String),
        json['appDarkMode'] as bool,
        json['appNotifications'] as bool,
      );

  @override
  Map<String, dynamic> toJson(SettingsState state) => <String, dynamic>{
        'locale': state.locale.languageCode,
        'appDarkMode': state.appDarkMode,
        'appNotifications': state.appNotifications,
      };

  void setAppLocale(String value) => emit(SettingsState(Locale(value), state.appDarkMode, state.appNotifications));

  void setAppDarkMode(bool value) => emit(SettingsState(state.locale, value, state.appNotifications));

  void setAppNotification(bool value) => emit(SettingsState(state.locale, state.appDarkMode, value));
}
