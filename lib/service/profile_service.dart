import 'package:ai_voting_app/core/extension%20/failure.dart';
import 'package:ai_voting_app/feature/profile/model/profile_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  ProfileService(this.client);
  final SupabaseClient client;
  User? get currentUser => client.auth.currentUser;
  Future<Either<Failure, ProfileModel>> getProfileData() async {
    try {
      final response = await client.rpc(
        'get_user_profile',
        params: {'user_uuid': currentUser?.id},
      );
      final profile = ProfileModel.fromMap(response);
      print(profile);
      return right(profile);
    } on PostgrestException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('Something went wrong. Please try again.'));
    }
  }
}
