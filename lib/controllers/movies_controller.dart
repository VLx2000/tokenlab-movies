import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tokenlab_movies/models/movie_details_model.dart';
import 'package:tokenlab_movies/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesRepository {
  Future<List<Movie>> getMoviesList() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2'),
      );

      List<Movie> movieList = (jsonDecode(response.body) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return movieList;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<MovieDetails> getMovieDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2/$id'),
      );

      MovieDetails movie = MovieDetails.fromJson(jsonDecode(response.body));
      return movie;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('erro');
    }
  }
}
