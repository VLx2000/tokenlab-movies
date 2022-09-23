import 'package:flutter/material.dart';
import 'package:tokenlab_movies/controllers/movies_controller.dart';
import 'package:tokenlab_movies/views/HomeView/widgets/movie_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MoviesController _controller = MoviesController();

  @override
  void initState() {
    super.initState();
    // na primeira execução ira preencher lista de filmes
    _controller.getMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;

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
                // caso em que ocorreu problema e n foi possivel
                // popular lista de filmes nenhuma vez
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
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () => _controller.getMoviesList(),
                    // criando cards de filmes em formato de grid
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
                  ),
                  // caso em que ocorreu problema e lista de filmes
                  // ja foi carregada pelo menos uma vez
                  if (_controller.errorMoviesList.value)
                    Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ElevatedButton.icon(
                          onPressed: () => _controller.getMoviesList(),
                          icon: const Icon(
                            Icons.refresh,
                            size: 24.0,
                          ),
                          label: const Text('Não foi possível atualizar'),
                        ),
                      ),
                    ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
