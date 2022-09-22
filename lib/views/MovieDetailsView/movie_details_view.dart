import 'package:flutter/material.dart';
import 'package:tokenlab_movies/controllers/movies_controller.dart';
import 'package:tokenlab_movies/models/movie_details_model.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/backdrop_widget.dart';
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
    return FutureBuilder<MovieDetails>(
      future: futureGame,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('filme nº${widget.id}'),
            ),
            body: const Center(
              child: Text("Ocorreu um erro ao buscar o filme :("),
            ),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    title: Text(
                      snapshot.data!.title,
                      style: const TextStyle(
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 5.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    expandedHeight: 400.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: BackdropWidget(
                        title: snapshot.data!.title,
                        url: snapshot.data!.backdropUrl,
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 42,
                ),
                child: Column(
                  children: [
                    // Titulo e data de lançamento
                    TitleReleaseWidget(
                      title: snapshot.data!.title,
                      releaseDate: snapshot.data!.releaseDate,
                      distanceItens: distanceItens,
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
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('filme nº${widget.id}'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}
