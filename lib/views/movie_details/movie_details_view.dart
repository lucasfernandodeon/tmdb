import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb/states/movie_details_states.dart';
import 'package:tmdb/stores/movie_details_store.dart';
import 'package:tmdb/widgets/information_widget.dart';
import 'package:tmdb/widgets/loading_widget.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/poster_widget.dart';

class MovieDetailsView extends StatefulWidget {
  final int movieId;

  const MovieDetailsView({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  MovieDetailsStore movieDetailsStore = GetIt.instance.get();

  VideoPlayerController? _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await movieDetailsStore.getMovieDetails(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text("Detalhes"),
        ),
        body: ValueListenableBuilder<MovieDetailsState>(
            valueListenable: movieDetailsStore,
            builder: (_, movieDetailsState, __) {
              if (movieDetailsState is LoadingMovieDetailsState) {
                return const LoadingWidget();
              } else if (movieDetailsState is ErrorMovieDetailsState) {
                return InformationWidget(message: movieDetailsState.error);
              } else if (movieDetailsState is SuccessMovieDetailsState) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: PosterWidget(
                              posterPath: movieDetailsState
                                  .movieDetailsModel.posterPath,
                            )),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                movieDetailsStore.favoriteMovieDetails(
                                    widget.movieId,
                                    movieDetailsState.movieDetailsModel);
                              },
                              icon: Icon(
                                movieDetailsState.movieDetailsModel.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white,
                              ),
                              label: Text(
                                  movieDetailsState.movieDetailsModel.favorite
                                      ? 'Remover dos favoritos'
                                      : "Adicionar aos favoritos"), // <-- Text
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () {
                                // _controller = VideoPlayerController.network(
                                //     '',
                                // videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              label: const Text('Trailer'), // <-- Text
                            ),
                          ]),
                      Text(
                        movieDetailsState.movieDetailsModel.overview ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.justify,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              const WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.calendar_month,
                                      size: 14,
                                      color: Colors.white,
                                    )),
                              ),
                              TextSpan(
                                text: movieDetailsState
                                    .movieDetailsModel.releaseDate,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              const WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.timelapse_sharp,
                                      size: 14,
                                      color: Colors.white,
                                    )),
                              ),
                              TextSpan(
                                text:
                                    "${movieDetailsState.movieDetailsModel.runtime} minutos",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              const WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.grade,
                                      size: 14,
                                      color: Colors.deepOrange,
                                    )),
                              ),
                              TextSpan(
                                text:
                                    "${movieDetailsState.movieDetailsModel.voteAverage}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}
