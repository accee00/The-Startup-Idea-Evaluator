part of 'idea_cubit.dart';

sealed class IdeaState extends Equatable {
  final List<StartupIdeaModel> ideas;
  const IdeaState({this.ideas = const <StartupIdeaModel>[]});
  @override
  List<Object?> get props => <Object?>[ideas];
}

final class IdeaInitial extends IdeaState {
  const IdeaInitial() : super(ideas: const <StartupIdeaModel>[]);
}

class LoadingState extends IdeaState {
  const LoadingState({required super.ideas});
}

class GetStartupIdeasSuccessState extends IdeaState {
  const GetStartupIdeasSuccessState({required super.ideas});
}

class GetStartupIdeasFailureState extends IdeaState {
  final String errorMessage;
  const GetStartupIdeasFailureState(this.errorMessage, {super.ideas});
  @override
  List<Object?> get props => <Object?>[errorMessage, ideas];
}

class AddStartupIdeaSuccessState extends IdeaState {
  const AddStartupIdeaSuccessState({required super.ideas});
}

class AddStartupIdeaFailureState extends IdeaState {
  final String errorMessage;
  const AddStartupIdeaFailureState(this.errorMessage, {super.ideas});
  @override
  List<Object?> get props => <Object?>[errorMessage, ideas];
}

class ToogleVoteSuccessState extends IdeaState {
  const ToogleVoteSuccessState({required super.ideas});
}

class ToogleVoteFailureState extends IdeaState {
  final String errorMessage;
  const ToogleVoteFailureState(this.errorMessage, {super.ideas});
  @override
  List<Object?> get props => <Object?>[errorMessage, ideas];
}

class FetchLeaderBoardSuccessState extends IdeaState {
  final List<StartupIdeaModel> leaderBoard;
  const FetchLeaderBoardSuccessState(this.leaderBoard, {required super.ideas});
  @override
  List<Object?> get props => <Object?>[leaderBoard, ideas];
}

class FetchLeaderBoardFailureState extends IdeaState {
  final String errorMessage;
  const FetchLeaderBoardFailureState(this.errorMessage, {super.ideas});
  @override
  List<Object?> get props => <Object?>[errorMessage, ideas];
}
