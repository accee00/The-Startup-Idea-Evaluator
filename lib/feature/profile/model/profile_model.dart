import 'package:equatable/equatable.dart';

import 'package:ai_voting_app/feature/idea/model/startup_idea_model.dart';

class ProfileModel extends Equatable {
  final String ideadSubmitted;
  final String votesGiven;
  final String votesReceived;
  final List<StartupIdeaModel> myIdeas;
  const ProfileModel({
    required this.ideadSubmitted,
    required this.votesGiven,
    required this.votesReceived,
    required this.myIdeas,
  });

  @override
  List<Object?> get props => [
    ideadSubmitted,
    votesGiven,
    votesReceived,
    myIdeas,
  ];

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      ideadSubmitted: map['idead_submitted'] as String,
      votesGiven: map['votes_given'] as String,
      votesReceived: map['votes_received'] as String,
      myIdeas:
          (map['myIdeas'] as List<dynamic>?)
              ?.map((x) => StartupIdeaModel.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
