import '../models/movies_model.dart';

abstract class MoviesState {}

class LoadingMoviesState extends MoviesState {}

class ErrorMoviesState extends MoviesState {
  final String error;

  ErrorMoviesState(this.error);
}

class SuccessMoviesState extends MoviesState {
  final List<MoviesModel> moviesList;

  SuccessMoviesState(this.moviesList);
}
