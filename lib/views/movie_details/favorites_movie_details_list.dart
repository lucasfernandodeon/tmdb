import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb/states/movie_details_favorites_states.dart';
import 'package:tmdb/stores/favorites_movie_details_store.dart';
import 'package:tmdb/views/movie_details/favorite_movie_details_adapter.dart';

import '../../widgets/information_widget.dart';
import '../../widgets/loading_widget.dart';

class MovieDetailsFavoritesList extends StatefulWidget {
  const MovieDetailsFavoritesList({Key? key}) : super(key: key);

  @override
  State<MovieDetailsFavoritesList> createState() =>
      _MovieDetailsFavoritesListState();
}

class _MovieDetailsFavoritesListState extends State<MovieDetailsFavoritesList> {
  FavoritesMovieDetailsStore favoritesMovieDetailsStore = GetIt.instance.get();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await favoritesMovieDetailsStore.getFavoritesMovieDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favoritos"),
        ),
        body: ValueListenableBuilder<FavoritesMovieDetailsStates>(
          valueListenable: favoritesMovieDetailsStore,
          builder: (_, favoritesMovieDetailsState, __) {
            if (favoritesMovieDetailsState
                is LoadingMovieDetailsFavoritesState) {
              return const LoadingWidget();
            } else if (favoritesMovieDetailsState
                is ErrorFavoritesMovieDetailsState) {
              return InformationWidget(
                  message: favoritesMovieDetailsState.error);
            } else if (favoritesMovieDetailsState
                is SuccessFavoritesMovieDetailsState) {
              if(favoritesMovieDetailsState
                  .favoritesMoviesDetailsList.isEmpty){
                return const InformationWidget(message: "Não há favoritos");
              }
              return GridView(
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                  ),
                  // Gera 100 Widgets que exibem o seu índice
                  children: favoritesMovieDetailsState
                      .favoritesMoviesDetailsList
                      .map((e) {
                    return FavoriteMovieDetailsAdapter(movieDetailsModel: e);
                  }).toList());
            } else {
              return Container();
            }
          },
        ));
  }
}
