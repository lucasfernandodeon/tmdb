import 'package:flutter/material.dart';
import 'package:tmdb/widgets/poster_widget.dart';
import '../../models/movies_model.dart';

class MovieAdapter extends StatelessWidget {
  final MoviesModel moviesModel;

  const MovieAdapter({Key? key, required this.moviesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 5, bottom: 15),
                child: PosterWidget(
                  posterPath: moviesModel.posterPath,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                moviesModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall,
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
                      text: moviesModel.releaseDate,
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
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
                    text: "${moviesModel.voteAverage}",
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
