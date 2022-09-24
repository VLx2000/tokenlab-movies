import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tokenlab_movies/models/movie_details_model.dart';
import 'package:tokenlab_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:tokenlab_movies/utils/consts.dart';

class MoviesController {
  ValueNotifier<List<Movie>> moviesList = ValueNotifier<List<Movie>>([]);
  ValueNotifier<bool> loadingMoviesList = ValueNotifier<bool>(false);
  ValueNotifier<bool> errorMoviesList = ValueNotifier<bool>(false);

  Future<void> getMoviesList() async {
    loadingMoviesList.value = true;
    errorMoviesList.value = false;
    List<Movie> temp = moviesList.value;
    moviesList.value = [];
    try {
      final response = await http.get(
        Uri.parse(Consts().API_URL),
      );
      loadingMoviesList.value = false;
      if (response.statusCode != 200) {
        throw Exception('Problema na resposta do servidor');
      } else {
        moviesList.value = (jsonDecode(response.body) as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
      loadingMoviesList.value = false;
      errorMoviesList.value = true;
      moviesList.value = temp;
    }
  }

  Future<MovieDetails> getMovieDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${Consts().API_URL}/$id'),
      );
      if (response.statusCode != 200) {
        throw Exception('Problema na resposta do servidor');
      } else {
        MovieDetails movie = MovieDetails.fromJson(jsonDecode(response.body));
        return movie;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Ocorreu um erro');
    }
  }
}
