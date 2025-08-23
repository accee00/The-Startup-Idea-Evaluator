import 'package:equatable/equatable.dart';

class StartupIdeaModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final String author;
  final double aiRating;
  final String? aiFeedback;
  final int votes;

  final bool hasVoted;
  final DateTime timestamp;
  const StartupIdeaModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.author,
    required this.aiRating,
    this.aiFeedback,
    required this.votes,

    required this.hasVoted,
    required this.timestamp,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
