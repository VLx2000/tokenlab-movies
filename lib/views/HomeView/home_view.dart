import 'package:flutter/material.dart';
import 'package:tokenlab_movies/controllers/movies_controller.dart';
import 'package:tokenlab_movies/views/HomeView/widgets/movie_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final MoviesController _controller = MoviesController();

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;
    _controller.getMoviesList();
    return Scaffold(
      appBar: AppBar(title: const Text('Tokenlab Movies')),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _controller.moviesList,
          builder: ((context, moviesList, loading) {
            if (moviesList.isEmpty) {
              if (_controller.loadingMoviesList.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
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
                      onPressed: () => _controller.getMoviesList(),
                      icon: const Icon(
                        Icons.refresh,
                        size: 24.0,
                      ),
                      label: const Text('Recarregar'),
                    ),
                  ],
                );
              }
            } else {
              return RefreshIndicator(
                onRefresh: () => _controller.getMoviesList(),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: tam < 1 ? 1 : tam,
                    childAspectRatio: 0.75,
                  ),
                  padding: const EdgeInsets.all(14),
                  itemCount: moviesList.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.all(7),
                      child: MovieCard(
                        id: moviesList[i].id,
                        posterUrl: moviesList[i].posterUrl,
                        title: moviesList[i].title,
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
