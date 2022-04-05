import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vk_reels/presentation/router/app_router.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationOpenStories());

  void navigate(String value) {
    switch (value) {
      case AppRouter.search:
        emit(const NavigationOpenSearch());
        break;
      case AppRouter.addStory:
        emit(const NavigationOpenAddStory());
        break;
      case AppRouter.favorites:
        emit(const NavigationOpenFavorites());
        break;
      case AppRouter.profile:
        emit(const NavigationOpenProfile());
        break;
      case AppRouter.stories:
      default:
        emit(const NavigationOpenStories());
    }
  }
}
