import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/widgets/loading_widget.dart';

import '../core/constants.dart';

class PosterWidget extends StatelessWidget {
  final String? posterPath;

  const PosterWidget({Key? key, this.posterPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget errorImageLoad = const Icon(Icons.image_not_supported);
    if (posterPath == null) {
      return errorImageLoad;
    }

    return CachedNetworkImage(
      errorWidget: (context, url, error) => errorImageLoad,
      progressIndicatorBuilder: (context, url, progress) =>
          const LoadingWidget(),
      imageUrl: Constants.posterEnpoint + posterPath!,
    );
  }
}
