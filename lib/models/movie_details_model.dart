import '../core/utils/date_format.dart';

class MovieDetailsModel {
  late int movieId;
  String? posterPath;
  String? overview;
  late String releaseDate;
  late bool video;
  late double voteAverage;
  double? runtime;
  late bool favorite;

  MovieDetailsModel.fromJson(dynamic json, bool favoriteDatabase) {
    movieId = json['id'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    releaseDate = dateFormat.format(DateTime.parse(json['release_date']));
    voteAverage = json['vote_average'];
    runtime = (json['runtime']).toDouble();
    video = json['video'];
    favorite = favoriteDatabase;
  }

  Map<String, dynamic> toJsonDatabase() {
    return {
      'movie_id': movieId,
      'poster_path': posterPath,
      'overview': overview,
      'release_date': releaseDate,
      'video': video ? 1 : 0,
      'vote_average': voteAverage,
      'runtime': voteAverage,
    };
  }

  MovieDetailsModel.fromJsonDatabase(dynamic json) {
    movieId = json['movie_id'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
    runtime = (json['runtime']).toDouble();
    video = json['video'] == 1 ? true : false;
    favorite = true;
  }
}
