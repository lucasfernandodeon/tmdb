import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tmdb/models/movie_details_model.dart';
import 'package:tmdb/states/movie_details_favorites_states.dart';
import '../core/database/tmdb_database.dart';

class FavoritesMovieDetailsStore
    extends ValueNotifier<FavoritesMovieDetailsStates> {
  late Database databaseInstance;

  FavoritesMovieDetailsStore() : super(LoadingMovieDetailsFavoritesState());

  Future getFavoritesMovieDetails() async {
    databaseInstance = await TmdbDatabase().database;
    value = LoadingMovieDetailsFavoritesState();
    try {
      var result = await databaseInstance.query("movie_details_favorite");
      List<MovieDetailsModel> auxListMovieDetails = [];
      for (var movieDetails in result) {
        auxListMovieDetails
            .add(MovieDetailsModel.fromJsonDatabase(movieDetails));
      }
      value = SuccessFavoritesMovieDetailsState(auxListMovieDetails);
    } catch (error) {
      value = ErrorFavoritesMovieDetailsState(
          "Ocorreu um erro ao buscar os favoritos. Tente novamente.");
    }
  }
}
