class Movie {
  final int id;
  final String title;
  final String originalTitle;
  final String backdropPath;
  final String posterPath;
  final String description;
  final double rating;
  final String date;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.backdropPath,
    required this.posterPath,
    required this.description,
    required this.rating,
    required this.date,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      backdropPath: map['backdrop_path'],
      description: map['overview'],
      rating: map['vote_average'],
      date: map['release_date'],
      posterPath: map['poster_path'],
      originalTitle: map['original_title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'overview': description,
      'vote_average': rating,
      'release_date': date,
    };
  }

  String getYear() {
    return date.substring(0, 4);
  }
}
