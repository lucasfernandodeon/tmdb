import 'package:tmdb/core/key.dart';

class Constants {
  static const String posterEnpoint = "https://image.tmdb.org/t/p/original";
  static const String movieDetailsEnpoint =
      "https://api.themoviedb.org/3/movie/";
  static const String nowPlayingEndpoint =
      "https://api.themoviedb.org/3/movie/now_playing";
  static const String language = "&language=pt-BR";
  static const String apiKeyPrefix = "?api_key=";
  static const String apiInfo = "$apiKeyPrefix$key$language";
}
