import 'package:flutter/material.dart';
import 'package:tokenlab_movies/controllers/movies_controller.dart';
import 'package:tokenlab_movies/models/movie_details_model.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/backdrop_widget.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/genre_widget.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/overview_widget.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/rating_widget.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/top_info_widget.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({super.key, required this.id});
  final int id;
  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late Future<MovieDetails> futureMovie;
  final MoviesController _controller = MoviesController();
  double distanceItens = 18;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    futureMovie = _controller.getMovieDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // utilizando future builder, pois
    // so será carregada uma vez
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tokenlab Movies'),
        centerTitle: true,
      ),
      body: FutureBuilder<MovieDetails>(
        future: futureMovie,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Ocorreu um erro ao buscar o filme :(",
                          style: TextStyle(
                            color: Colors.white,
                            decorationColor: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              futureMovie =
                                  _controller.getMovieDetails(widget.id);
                              isLoading = true;
                            });
                            Future.delayed(const Duration(seconds: 2),
                                () => setState(() => isLoading = false));
                          },
                          icon: const Icon(
                            Icons.refresh,
                            size: 24.0,
                          ),
                          label: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
          } else if (snapshot.hasData) {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: BackdropWidget(
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
                    // Titulo, duração e data de lançamento
                    TopInfoWidget(
                      title: snapshot.data!.title,
                      releaseDate: snapshot.data!.releaseDate,
                      runtime: snapshot.data!.runtime,
                      posterUrl: snapshot.data!.posterUrl,
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
            );
          } else {
            // por padrao exibe loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
