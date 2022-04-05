part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final VKUserProfile profile;
  final bool isLoading;
  final ErrorResult? error;

  const ProfileState._({this.profile = VKUserProfile.empty, this.isLoading = false, this.error});

  const ProfileState.loading() : this._(isLoading: true);

  const ProfileState.loaded(VKUserProfile profile) : this._(profile: profile, isLoading: false);

  const ProfileState.error(ErrorResult error) : this._(error: error, isLoading: false);

  @override
  List<Object?> get props => [profile, isLoading, error];
}
