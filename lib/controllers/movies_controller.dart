import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tokenlab_movies/models/movie_details_model.dart';
import 'package:tokenlab_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesController {
  ValueNotifier<List<Movie>> moviesList = ValueNotifier<List<Movie>>([]);
  ValueNotifier<bool> loadingMoviesList = ValueNotifier<bool>(false);

  String apiUrl =
      'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2';

  Future<void> getMoviesList() async {
    loadingMoviesList.value = true;
    moviesList.value = [];
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );
      loadingMoviesList.value = false;
      moviesList.value = (jsonDecode(response.body) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      loadingMoviesList.value = false;
      moviesList.value = [];
    }
    return;
  }

  Future<MovieDetails> getMovieDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/$id'),
      );
      MovieDetails movie = MovieDetails.fromJson(jsonDecode(response.body));
      return movie;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('erro');
    }
  }
}
