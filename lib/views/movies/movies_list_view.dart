import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb/states/movies_states.dart';
import 'package:tmdb/views/movie_details/favorites_movie_details_list.dart';
import 'package:tmdb/views/movies/movie_adapter.dart';
import 'package:tmdb/widgets/information_widget.dart';
import 'package:tmdb/widgets/loading_widget.dart';
import '../../stores/movies_store.dart';
import '../movie_details/movie_details_view.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({Key? key}) : super(key: key);

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  final MoviesStore moviesStore = GetIt.instance.get();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await moviesStore.getMovies();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("TMDB"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MovieDetailsFavoritesList()));
              },
              icon: const Icon(
                Icons.favorite,
                size: 24.0,
              ),
              label: const Text('Favoritos'), // <-- Text
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<MoviesState>(
          valueListenable: moviesStore,
          builder: (_, state, __) {
            if (state is LoadingMoviesState) {
              return const LoadingWidget();
            } else if (state is ErrorMoviesState) {
              return InformationWidget(message: state.error);
            } else if (state is SuccessMoviesState) {
              if(state.moviesList.isEmpty){
                return const InformationWidget(message: "Não foram encontrados filmes.");
              }

              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  moviesStore.getMovies();
                  return true;
                },
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.red,
                  child: GridView(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      // Gera 100 Widgets que exibem o seu índice
                      children: state.moviesList.map((e) {
                        return GestureDetector(
                            onTap: () {
                              // developer.log("aaaaaaa");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetailsView(
                                            movieId: e.id,
                                          )));
                            },
                            child: MovieAdapter(moviesModel: e));
                      }).toList()),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
