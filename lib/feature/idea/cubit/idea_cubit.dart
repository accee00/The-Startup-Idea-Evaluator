import 'package:ai_voting_app/feature/idea/model/startup_idea_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'idea_state.dart';

class IdeaCubit extends Cubit<IdeaState> {
  IdeaCubit() : super(const IdeaInitial());
}
