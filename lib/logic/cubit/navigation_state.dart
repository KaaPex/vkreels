part of 'navigation_cubit.dart';

@immutable
class NavigationState extends Equatable {
  final String route;

  const NavigationState(this.route);

  @override
  List<Object> get props => [route];
}

class NavigationOpenStories extends NavigationState {
  const NavigationOpenStories() : super(AppRouter.stories);
}

class NavigationOpenSearch extends NavigationState {
  const NavigationOpenSearch() : super(AppRouter.search);
}

class NavigationOpenAddStory extends NavigationState {
  const NavigationOpenAddStory() : super(AppRouter.addStory);
}

class NavigationOpenFavorites extends NavigationState {
  const NavigationOpenFavorites() : super(AppRouter.favorites);
}

class NavigationOpenProfile extends NavigationState {
  const NavigationOpenProfile() : super(AppRouter.profile);
}
