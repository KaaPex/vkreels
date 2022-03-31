part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Locale locale;
  final bool appDarkMode;
  final bool appNotifications;

  const SettingsState(
    this.locale,
    this.appDarkMode,
    this.appNotifications,
  );

  @override
  List<Object?> get props => [locale, appDarkMode, appNotifications];
}
