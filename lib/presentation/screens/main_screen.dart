import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/core/constants/enums.dart';
import 'package:vk_reels/core/icons/custom_icons.dart';
import 'package:vk_reels/logic/bloc/authentication/authentication_bloc.dart';
import 'package:vk_reels/logic/cubit/internet_cubit.dart';
import 'package:vk_reels/logic/cubit/navigation_cubit.dart';

import '../router/app_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainScreen());
  }

  String _getPageRoute(int page) {
    switch (page) {
      case 1:
        return AppRouter.search;
      case 2:
        return AppRouter.addStory;
      case 3:
        return AppRouter.favorites;
      case 4:
        return AppRouter.profile;
      case 0:
      default:
        return AppRouter.story;
    }
  }

  int _getPageIndex(String route) {
    switch (route) {
      case AppRouter.search:
        return 1;
      case AppRouter.addStory:
        return 2;
      case AppRouter.favorites:
        return 3;
      case AppRouter.profile:
        return 4;
      case AppRouter.story:
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return Text(state.user.firstName);
                },
              ),
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Wi-Fi',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.green,
                          ),
                    );
                  } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Mobile',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.red,
                          ),
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.grey,
                          ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            final currentIndex = _getPageIndex(state.route);
            return CupertinoTabBar(
              activeColor: Theme.of(context).tabBarTheme.labelColor,
              inactiveColor: Theme.of(context).tabBarTheme.unselectedLabelColor!,
              currentIndex: currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.storyOutline,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.search,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: '',
                )
              ],
              onTap: (int page) {
                final route = _getPageRoute(page);
                context.read<NavigationCubit>().navigate(route);
              },
            );
          },
        ),
      ),
    );
  }
}
