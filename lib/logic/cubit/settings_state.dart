part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Locale locale;
  final bool appNotifications;

  const SettingsState(
    this.locale,
    this.appNotifications,
  );

  @override
  List<Object?> get props => [locale, appNotifications];
}
