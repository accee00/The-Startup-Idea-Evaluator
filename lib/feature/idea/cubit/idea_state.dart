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
