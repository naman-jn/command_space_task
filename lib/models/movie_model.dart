import 'dart:convert';

class Movie {
  int id;
  String title;
  String posterPath;
  String overview;
  double voteAverage;
  String releaseDate;
  double popularity;
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.popularity,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      posterPath: map['poster_path'],
      overview: map['overview'],
      voteAverage: map['vote_average'],
      releaseDate: map['release_date'],
      popularity: map['popularity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'popularity': popularity,
    };
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, posterPath: $posterPath, overview: $overview, voteAverage: $voteAverage, releaseDate: $releaseDate, popularity: $popularity)';
  }
}
