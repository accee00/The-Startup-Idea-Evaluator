import 'package:equatable/equatable.dart';

class IdeaModel extends Equatable {
  const IdeaModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    required this.votes,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String tagline;
  final String description;
  final int rating;
  final int votes;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    id,
    name,
    tagline,
    description,
    rating,
    votes,
    createdAt,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'rating': rating,
      'votes': votes,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory IdeaModel.fromMap(Map<String, dynamic> map) {
    return IdeaModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      tagline: map['tagline']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      rating: map['rating'] as int,
      votes: map['votes'] as int,
      createdAt: map['created_at'],
    );
  }
}
