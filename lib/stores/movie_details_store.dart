import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:tmdb/core/constants.dart';
import 'package:tmdb/core/database/tmdb_database.dart';
import 'package:tmdb/states/movie_details_states.dart';
import '../models/movie_details_model.dart';

class MovieDetailsStore extends ValueNotifier<MovieDetailsState> {
  late Database databaseInstance;

  MovieDetailsStore() : super(LoadingMovieDetailsState());

  Future getMovieDetails(int movieId) async {
    value = LoadingMovieDetailsState();
    try {
      var result = await http.get(Uri.parse(
          "${Constants.movieDetailsEnpoint}$movieId${Constants.apiInfo}"));
      var json = jsonDecode(result.body);
      bool favoriteDatabase = await _checkFavorite(movieId);
      value = SuccessMovieDetailsState(
          movieDetailsModel:
              MovieDetailsModel.fromJson(json, favoriteDatabase));
    } catch (error) {
      value = ErrorMovieDetailsState(
          error: "Ocorreu um erro na busca. Tente novamente.");
    }
  }

  Future<bool> _checkFavorite(int movieId) async {
    databaseInstance = await TmdbDatabase().database;
    var result = await databaseInstance.query("movie_details_favorite",
        where: "movie_id=?", whereArgs: [movieId]);
    return result.isNotEmpty;
  }

  Future favoriteMovieDetails(
      int movieId, MovieDetailsModel movieDetailsModel) async {
    databaseInstance = await TmdbDatabase().database;

    movieDetailsModel.favorite = !movieDetailsModel.favorite;
    value = SuccessMovieDetailsState(movieDetailsModel: movieDetailsModel);

    if (!movieDetailsModel.favorite) {
      await databaseInstance.delete("movie_details_favorite",
          where: "movie_id=?", whereArgs: [movieId]);
    } else {
      await databaseInstance.insert(
          'movie_details_favorite', movieDetailsModel.toJsonDatabase());
    }
  }
}
