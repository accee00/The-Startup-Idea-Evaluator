part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState([
    this.userProfile = const ProfileModel(
      ideadSubmitted: '',
      votesGiven: '',
      votesReceived: '',
      myIdeas: [],
    ),
  ]);

  final ProfileModel userProfile;

  @override
  List<Object> get props => [userProfile];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial() : super();
}

class UserProileLoadedState extends ProfileState {
  const UserProileLoadedState(super.userProfile);
  @override
  List<Object> get props => [userProfile];
}
