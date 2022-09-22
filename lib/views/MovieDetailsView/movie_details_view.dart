import 'package:flutter/material.dart';
import 'package:tokenlab_movies/controllers/movies_controller.dart';
import 'package:tokenlab_movies/models/movie_details_model.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/backdrop_widget.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/poster_widget.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/genre_column.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/overview_line.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/rating_column.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/title_and_release_widget.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({super.key, required this.id});
  final int id;
  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late Future<MovieDetails> futureGame;
  final MoviesController _controller = MoviesController();
  double distanceItens = 18;

  @override
  void initState() {
    super.initState();
    futureGame = _controller.getMovieDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('filme nº${widget.id}'),
      ),
      body: FutureBuilder<MovieDetails>(
        future: futureGame,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Ocorreu um erro ao buscar o filme :("),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 12,
              ),
              child: Column(
                children: [
                  // Titulo do jogo e data de lançamento
                  TitleReleaseWidget(
                    title: snapshot.data!.title,
                    releaseDate: snapshot.data!.releaseDate,
                    distanceItens: distanceItens,
                  ),
                  // Cover do jogo
                  PosterWidget(
                    title: snapshot.data!.title,
                    url: snapshot.data!.posterUrl,
                  ),
                  // Linha de generos e avaliação
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: distanceItens, top: distanceItens),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GenreWidget(
                            genres: snapshot.data?.genres,
                          ),
                          RatingWidget(
                            rating: snapshot.data?.voteAverage,
                          ),
                        ]),
                  ),
                  // Linha de descrição
                  OverviewWidget(
                    overview: snapshot.data?.overview,
                    distanceItens: distanceItens,
                  ),
                  BackdropWidget(
                    title: snapshot.data!.title,
                    url: snapshot.data!.backdropUrl,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
