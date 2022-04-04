import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:vk_sdk/vk_sdk.dart';

import 'app.dart';
import 'data/repository/vk_sdk_repository.dart';
import 'logic/debug/app_observer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  final vkSdkRepository = VkSdkRepository(vkSdk: VkSdk(debug: true));
  await vkSdkRepository.init();

  HydratedBlocOverrides.runZoned(
    () => runApp(
      App(
        connectivity: Connectivity(),
        vkSdkRepository: vkSdkRepository,
      ),
    ),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}
