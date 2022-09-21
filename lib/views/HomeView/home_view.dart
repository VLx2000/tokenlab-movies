import 'package:flutter/material.dart';
import 'package:tokenlab_movies/models/movie_model.dart';
import 'package:tokenlab_movies/controllers/movies_controller.dart';
import 'package:tokenlab_movies/views/HomeView/widgets/movie_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Movie>> futureMovies;
  MoviesRepository repository = MoviesRepository();

  @override
  void initState() {
    super.initState();
    futureMovies = repository.getMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;

    return Scaffold(
      appBar: AppBar(title: const Text('Tokenlab Movies')),
      body: Center(
        child: FutureBuilder<List<Movie>>(
          future: futureMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Movie> list = snapshot.data ?? [];
              if (list.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Verifique sua conexão',
                      style: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          futureMovies = repository.getMoviesList();
                        });
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 24.0,
                      ),
                      label: const Text('Recarregar'),
                    ),
                  ],
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () {
                    setState(() {
                      futureMovies = repository.getMoviesList();
                    });
                    return futureMovies;
                  },
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: tam < 1 ? 1 : tam,
                      childAspectRatio: 0.75,
                    ),
                    padding: const EdgeInsets.all(14),
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: const EdgeInsets.all(7),
                        child: MovieCard(
                          id: list[i].id,
                          posterUrl: list[i].posterUrl,
                          title: list[i].title,
                        ),
                      );
                    },
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
