class Movie {
  final int id;
  final double voteAverage;
  final String title;
  final String posterUrl;
  final List<dynamic> genres;
  final String releaseDate;

  Movie({
    required this.id,
    required this.voteAverage,
    required this.title,
    required this.posterUrl,
    required this.genres,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      voteAverage: json['vote_average'],
      title: json['title'],
      posterUrl: json['poster_url'],
      genres: json['genres'],
      releaseDate: json['release_date'],
    );
  }
}
