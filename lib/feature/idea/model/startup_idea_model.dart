import 'package:equatable/equatable.dart';

class StartupIdeaModel extends Equatable {
  final String? id;
  final String title;
  final String description;
  final String category;
  final String? authorId;
  final double aiRating;
  final String? aiFeedback;
  final int votes;
  final String? authorName;
  final bool hasVoted;
  final DateTime createdAt;
  const StartupIdeaModel({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.authorId,
    required this.aiRating,
    this.aiFeedback,
    required this.votes,
    required this.hasVoted,
    required this.createdAt,
    this.authorName,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    authorId,
    aiRating,
    aiFeedback,
    votes,
    hasVoted,
    createdAt,
    authorName,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'author': authorId,
      'ai_rating': aiRating,
      'author_name': authorName,
      'ai_feedback': aiFeedback,
      'votes': votes,
      'has_voted': hasVoted,
      'created_at': createdAt.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  factory StartupIdeaModel.fromMap(Map<String, dynamic> map) {
    return StartupIdeaModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      authorId: map['author']?.toString() ?? '',
      aiRating: map['ai_rating'] != null
          ? (map['ai_rating'] as num).toDouble()
          : 0.0,
      aiFeedback: map['ai_feedback']?.toString(),
      authorName: map['author_name']?.toString() ?? '',
      votes: map['votes'] != null ? (map['votes'] as num).toInt() : 0,
      hasVoted: map['has_voted'] == true,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  StartupIdeaModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? authorId,
    double? aiRating,
    String? aiFeedback,
    int? votes,
    bool? hasVoted,
    String? authorName,
    DateTime? createdAt,
  }) {
    return StartupIdeaModel(
      id: id ?? this.id,
      title: title ?? this.title,
      authorName: authorName ?? this.authorName,
      description: description ?? this.description,
      category: category ?? this.category,
      authorId: authorId ?? this.authorId,
      aiRating: aiRating ?? this.aiRating,
      aiFeedback: aiFeedback ?? this.aiFeedback,
      votes: votes ?? this.votes,
      hasVoted: hasVoted ?? this.hasVoted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
