import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/core/constants/enums.dart';
import 'package:vk_reels/core/icons/custom_icons.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_reels/logic/bloc/authentication/authentication_bloc.dart';
import 'package:vk_reels/logic/bloc/bloc.dart';
import 'package:vk_reels/logic/cubit/cubit.dart';
import 'package:vk_reels/presentation/pages/feed/feed.dart';
import 'package:vk_reels/presentation/pages/pages.dart';

import '../router/app_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainScreen());
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
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
        return AppRouter.feed;
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
      case AppRouter.feed:
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(vkSdkRepository: context.read<VkSdkRepository>()),
        )
      ],
      child: Scaffold(
        body: PageView(
          children: [
            const FeedPage(),
            Container(),
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
            Container(),
            ProfilePage(id: context.read<AuthenticationBloc>().state.userId),
          ],
          controller: pageController,
          // onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            final currentIndex = _getPageIndex(state.route);
            return CupertinoTabBar(
              activeColor: Theme.of(context).tabBarTheme.labelColor,
              inactiveColor: Theme.of(context).tabBarTheme.unselectedLabelColor!,
              currentIndex: currentIndex,
              backgroundColor: Theme.of(context).primaryColor,
              height: 35,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.newsFeed_24,
                  ),
                  label: '',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     CustomIcons.storyOutline_24,
                //   ),
                //   label: '',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.search_24,
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
                pageController.jumpToPage(page);
              },
            );
          },
        ),
      ),
    );
  }
}
