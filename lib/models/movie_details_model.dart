class MovieDetails {
  final int id;
  final double voteAverage;
  final String title;
  final String posterUrl;
  final List<dynamic> genres;
  final String releaseDate;
  final String overview;
  final int runtime;
  final String backdropUrl;

  MovieDetails({
    required this.id,
    required this.voteAverage,
    required this.title,
    required this.posterUrl,
    required this.genres,
    required this.releaseDate,
    required this.overview,
    required this.runtime,
    required this.backdropUrl,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      voteAverage: json['vote_average'],
      title: json['title'],
      posterUrl: json['poster_url'],
      genres: json['genres'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      runtime: json['runtime'],
      backdropUrl: json['backdrop_url'],
    );
  }
}
