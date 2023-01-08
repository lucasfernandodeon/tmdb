import '../core/utils/date_format.dart';

class MoviesModel {
  late int id;
  late String title;
  String? posterPath;
  late String releaseDate;
  late double voteAverage;

  MoviesModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    posterPath = json['poster_path'];
    releaseDate = dateFormat.format(DateTime.parse(json['release_date']));
    voteAverage = (json['vote_average']).toDouble();
  }
}
