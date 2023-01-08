import 'package:flutter/material.dart';
import 'package:tmdb/models/movie_details_model.dart';
import 'package:tmdb/widgets/poster_widget.dart';

class FavoriteMovieDetailsAdapter extends StatelessWidget {
  final MovieDetailsModel movieDetailsModel;

  const FavoriteMovieDetailsAdapter({Key? key, required this.movieDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PosterWidget(
      posterPath: movieDetailsModel.posterPath,
    );
  }
}
