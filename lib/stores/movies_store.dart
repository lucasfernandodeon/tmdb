import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/core/constants.dart';
import 'package:tmdb/models/movies_model.dart';
import '../states/movies_states.dart';

class MoviesStore extends ValueNotifier<MoviesState> {
  final http.Client client;
  int _pagesQuantity = 0;
  int _actualPage = 1;
  bool _isLoading=false;
  final List<MoviesModel> _moviesList = [];

  MoviesStore(this.client) : super(LoadingMoviesState());

  Future<void> getMovies() async {
    if (_actualPage == _pagesQuantity || _isLoading) {
      return;
    }
    if (_actualPage == 1) {
      value = LoadingMoviesState();
    }
    _isLoading=true;
    try {
      var result = await client.get(Uri.parse(
          "${Constants.nowPlayingEndpoint}${Constants.apiInfo}&page=$_actualPage"));
      var json = jsonDecode(result.body);
      _pagesQuantity = json['total_pages'];
      List<MoviesModel> auxMoviesList = [];

      for (var data in json['results']) {
        auxMoviesList.add(MoviesModel.fromJson(data));
      }
      _moviesList.addAll(auxMoviesList);
      value = SuccessMoviesState(_moviesList);
      _actualPage++;
    } catch (error) {
      if (_actualPage == 1) {
        value = ErrorMoviesState("Ocorreu um erro na busca. Tente novamente.");
      }
    }
    _isLoading=false;
  }
}
