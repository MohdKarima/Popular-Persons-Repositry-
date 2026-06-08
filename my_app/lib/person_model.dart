class PersonModel {
  final int id;
  final String name;
  final String? profilePath;
  final String department;
  final double popularity;
  final List<KnownFor> knownFor;

  PersonModel({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.department,
    required this.popularity,
    required this.knownFor,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      profilePath: json['profile_path'],
      department: json['known_for_department'],
      popularity: (json['popularity'] ?? 0).toDouble(),
      knownFor: json['known_for'] == null
          ? []
          : List<KnownFor>.from(
              json['known_for'].map((item) => KnownFor.fromJson(item)),
            ),
    );
  }
}

class KnownFor {
  final String title;
  final String overview;
  final String? posterPath;

  KnownFor({
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) {
    return KnownFor(
      title: json['title'] ?? json['name'] ?? 'No Title',
      overview: json['overview'] ?? 'No description available.',
      posterPath: json['poster_path'],
    );
  }
}
