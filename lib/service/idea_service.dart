import 'package:ai_voting_app/core/extension%20/failure.dart';
import 'package:ai_voting_app/feature/idea/model/startup_idea_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IdeaService {
  final SupabaseClient client;
  IdeaService(this.client);

  User? get currentUser => client.auth.currentUser;
  Future<Either<Failure, void>> addIdea(StartupIdeaModel idea) async {
    try {
      final StartupIdeaModel updatedIdea = idea.copyWith(
        authorId: currentUser?.id,
        authorName: currentUser?.userMetadata!["name"],
      );
      await client.from('ideas').insert(updatedIdea.toMap());
      return right(null);
    } on PostgrestException catch (e) {
      print(e.toJson());
      return left(Failure(e.message));
    } catch (_) {
      return left(Failure('Something went wrong. Please try again.'));
    }
  }

  Future<Either<Failure, List<StartupIdeaModel>>> fetchIdeas() async {
    try {
      final List<Map<String, dynamic>> response = await client
          .from('ideas')
          .select()
          .order('created_at', ascending: false);

      final List<StartupIdeaModel> ideas = response
          .map((idea) => StartupIdeaModel.fromMap(idea))
          .toList();
      return right(ideas);
    } on PostgrestException catch (e) {
      print(e.toJson());
      return left(Failure(e.message));
    } catch (_) {
      return left(Failure('Something went wrong. Please try again.'));
    }
  }

  Future<Either<Failure, List<StartupIdeaModel>>> toogleVotes({
    required String ideaId,
  }) async {
    try {
      await client.rpc(
        'toggle_vote',
        params: {'p_idea_id': ideaId, 'p_user_id': currentUser?.id},
      );

      final response = await client
          .from('ideas')
          .select()
          .order('created_at', ascending: false);

      final List<StartupIdeaModel> ideas = response
          .map((idea) => StartupIdeaModel.fromMap(idea))
          .toList();

      return right(ideas);
    } on PostgrestException catch (e) {
      print(e);
      return left(Failure('Something went wrong. Please try again.'));
    }
  }

  Future<bool> hasUserVoted({required String ideaId}) async {
    try {
      final response = await client
          .from('idea_votes')
          .select()
          .eq('idea_id', ideaId)
          .eq('user_id', currentUser!.id);

      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on PostgrestException catch (e) {
      print(e);
      return false;
    }
  }

  Future<Either<Failure, List<StartupIdeaModel>>> fetchLeaderBoard() async {
    try {
      final List<Map<String, dynamic>> response = await client
          .from('ideas')
          .select()
          .order('votes', ascending: false);

      final List<StartupIdeaModel> ideas = response
          .map((idea) => StartupIdeaModel.fromMap(idea))
          .toList();

      return right(ideas);
    } on PostgrestException catch (e) {
      print(e.toJson());
      return left(Failure(e.message));
    } catch (_) {
      return left(Failure('Something went wrong. Please try again.'));
    }
  }
}
