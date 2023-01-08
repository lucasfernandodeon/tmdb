import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/stores/favorites_movie_details_store.dart';
import 'package:tmdb/stores/movie_details_store.dart';
import 'package:tmdb/stores/movies_store.dart';

class Inject {
  static void init() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<http.Client>(() => http.Client());

    getIt.registerLazySingleton<MoviesStore>(() => MoviesStore(getIt.get()));

    getIt.registerLazySingleton<FavoritesMovieDetailsStore>(
        () => FavoritesMovieDetailsStore());

    // getIt.registerLazySingletonAsync<Database>(() async {
    //   return await TmdbDatabase().database;
    // });

    getIt.registerLazySingleton<MovieDetailsStore>(() => MovieDetailsStore());
  }
}
