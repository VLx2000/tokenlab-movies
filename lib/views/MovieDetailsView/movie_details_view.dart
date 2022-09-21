import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tokenlab_movies/models/movie_details_model.dart';
import 'package:tokenlab_movies/controllers/movies_controller.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/genre_column.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/overview_line.dart';
import 'package:tokenlab_movies/views/MovieDetailsView/widgets/rating_column.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({super.key, required this.id});
  final int id;
  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late Future<MovieDetails> futureGame;
  MoviesRepository repository = MoviesRepository();
  double distanceItems = 18;
  bool temImagem = false;
  bool verificou = false;

  Future<bool> verificaImg(String url) async {
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      debugPrint('entrou');
      if (mounted) {
        setState(() {
          temImagem = true;
          verificou = true;
        });
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    futureGame = repository.getMovieDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('movie ${widget.id}'),
      ),
      body: FutureBuilder<MovieDetails>(
        future: futureGame,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to retrieve movie"),
            );
          } else if (snapshot.hasData) {
            verificou ? null : verificaImg(snapshot.data!.posterUrl);
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 12,
              ),
              child: Column(
                children: [
                  // Titulo do jogo e data de lançamento
                  Container(
                    padding: EdgeInsets.only(bottom: distanceItems),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            softWrap: true,
                            snapshot.data!.title,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            snapshot.data!.releaseDate.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Cover do jogo
                  temImagem
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/coverNotFound.jpg',
                            placeholderFit: BoxFit.scaleDown,
                            image: snapshot.data!.posterUrl,
                            fit: BoxFit.scaleDown,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/coverNotFound.jpg'),
                          ),
                        )
                      : Container(
                          height: 300,
                          width: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                            color: Colors.white70,
                          ),
                          child: Center(
                            child: Text(
                              snapshot.data!.title,
                              textScaleFactor: 1.7,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                  // Linha de generos e avaliação
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: distanceItems, top: distanceItems),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GenreColumn(
                            genres: snapshot.data?.genres,
                          ),
                          RatingColumn(
                            rating: snapshot.data?.voteAverage,
                          ),
                        ]),
                  ),
                  // Linha de descrição
                  Padding(
                    padding: EdgeInsets.only(bottom: distanceItems),
                    child: OverviewLine(
                      overview: snapshot.data?.overview,
                    ),
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
