part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool appNotifications;

  const SettingsState(
    this.appNotifications,
  );

  @override
  List<Object?> get props => [appNotifications];
}
