import 'package:ai_voting_app/feature/idea/model/startup_idea_model.dart';
import 'package:ai_voting_app/service/idea_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'idea_state.dart';

class IdeaCubit extends Cubit<IdeaState> {
  IdeaCubit(this._ideaService) : super(const IdeaInitial());

  final IdeaService _ideaService;

  Future<void> getStartupIdeas() async {
    emit(LoadingState(ideas: state.ideas));
    final result = await _ideaService.fetchIdeas();
    result.fold(
      (failure) => emit(
        GetStartupIdeasFailureState(failure.message, ideas: state.ideas),
      ),
      (ideas) => emit(GetStartupIdeasSuccessState(ideas: ideas)),
    );
  }

  Future<void> addStartupIdea(StartupIdeaModel idea) async {
    emit(LoadingState(ideas: state.ideas));
    final result = await _ideaService.addIdea(idea);
    result.fold(
      (failure) =>
          emit(AddStartupIdeaFailureState(failure.message, ideas: state.ideas)),
      (_) => emit(AddStartupIdeaSuccessState(ideas: [...state.ideas, idea])),
    );
  }

  Future<void> toggleVote(String ideadId) async {
    final result = await _ideaService.toogleVotes(ideaId: ideadId);
    result.fold(
      (failure) =>
          emit(ToogleVoteFailureState(failure.message, ideas: state.ideas)),
      (updatedIdeas) {
        emit(ToogleVoteSuccessState(ideas: updatedIdeas));
      },
    );
  }

  Future<void> fetchLeaderBoardd() async {
    emit(LoadingState(ideas: state.ideas));
    final result = await _ideaService.fetchLeaderBoard();
    result.fold(
      (failure) => emit(
        FetchLeaderBoardFailureState(failure.message, ideas: state.ideas),
      ),
      (leaderBoard) =>
          emit(FetchLeaderBoardSuccessState(leaderBoard, ideas: state.ideas)),
    );
  }
}
