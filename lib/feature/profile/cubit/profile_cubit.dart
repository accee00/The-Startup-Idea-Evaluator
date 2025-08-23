import 'package:ai_voting_app/core/extension%20/failure.dart';
import 'package:ai_voting_app/feature/profile/model/profile_model.dart';
import 'package:ai_voting_app/service/profile_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileService) : super(const ProfileInitial());
  final ProfileService profileService;

  Future<void> fetchUserProfile() async {
    final Either<Failure, ProfileModel> response = await profileService
        .getProfileData();
    response.fold(
      (failure) => emit(const ProfileInitial()),
      (profileData) => emit(UserProileLoadedState(profileData)),
    );
  }
}
