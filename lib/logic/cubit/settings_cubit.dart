import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(true));

  @override
  SettingsState fromJson(Map<String, dynamic> json) => SettingsState(
        json['appNotifications'] as bool,
      );

  @override
  Map<String, dynamic>? toJson(SettingsState state) => <String, dynamic>{
        'appNotifications': state.appNotifications,
      };

  void setAppNotification(bool value) => emit(SettingsState(value));
}
