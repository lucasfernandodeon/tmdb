import 'package:tmdb/models/movie_details_model.dart';

abstract class MovieDetailsState {}

class LoadingMovieDetailsState extends MovieDetailsState {}

class ErrorMovieDetailsState extends MovieDetailsState {
  final String error;

  ErrorMovieDetailsState({required this.error});
}

class SuccessMovieDetailsState extends MovieDetailsState {
  final MovieDetailsModel movieDetailsModel;

  SuccessMovieDetailsState({required this.movieDetailsModel});
}
