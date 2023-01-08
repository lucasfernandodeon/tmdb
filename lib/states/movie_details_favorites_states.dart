import 'package:tmdb/models/movie_details_model.dart';

abstract class FavoritesMovieDetailsStates {}

class LoadingMovieDetailsFavoritesState extends FavoritesMovieDetailsStates {}

class ErrorFavoritesMovieDetailsState extends FavoritesMovieDetailsStates {
  final String error;

  ErrorFavoritesMovieDetailsState(this.error);
}

class SuccessFavoritesMovieDetailsState extends FavoritesMovieDetailsStates {
  final List<MovieDetailsModel> favoritesMoviesDetailsList;

  SuccessFavoritesMovieDetailsState(this.favoritesMoviesDetailsList);
}
