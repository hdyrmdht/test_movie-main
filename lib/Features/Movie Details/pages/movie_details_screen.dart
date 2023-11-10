import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Data/data_source/movie%20details/movie_details_datasource.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';
import 'package:movie/Features/Home/manager/cubit.dart';
import 'package:movie/Features/Movie%20Details/manager/cubit.dart';
import 'package:movie/Features/Movie%20Details/manager/states.dart';

import '../../../Core/constants/costants.dart';
import '../../../Core/services/utils.dart';

class MovieDetailsScreen extends StatelessWidget {
  int movieId;

  MovieDetailsScreen(this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsCubit(RemoteMovieDetailsDto())
        ..getMovieDetails(movieId)
        ..getSimilarMovies(movieId),
      child: BlocConsumer<MovieDetailsCubit, MovieDetailsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var mediaquery = MediaQuery.of(context).size;
            var theme = Theme.of(context);
            var cubit = MovieDetailsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: theme.backgroundColor,
                elevation: 0,
                title: Text(cubit.movie?.title ?? "",
                    style: theme.textTheme.headlineLarge),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white, size: 22),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${Constants.imagePath}${cubit.movie?.backdropPath}",
                        placeholder: (context, url) => const Center(
                            child: Icon(Icons.movie_creation_outlined)),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("${cubit.movie?.title}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: theme.textTheme.displayLarge),
                    Text(formatMovieDate(cubit.movie?.releaseDate),
                        style: theme.textTheme.bodySmall),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: 10),
                          height: 205.h,
                          width: 135.w,
                          decoration: BoxDecoration(
                            color: const Color(0XFF282A28),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${Constants.imagePath}${cubit.movie?.posterPath}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: mediaquery.height * 0.07,
                              width: mediaquery.width * 0.5,
                              child: GridView.builder(
                                itemCount: cubit.movie?.genres?.length,
                                itemBuilder: (context, index) => Container(
                                  width: 65.w,
                                  height: 22.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0XFF282A28), width: 2)),
                                  child: Center(
                                      child: Text(
                                          cubit.movie?.genres?[index].name ??
                                              "")),
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 1,
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            Row(
                              children: [
                                const ImageIcon(
                                    AssetImage("assets/images/icons/star.png"),
                                    size: 16,
                                    color: Color(0XFFFFBB3B)),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                    "${cubit.movie?.voteAverage}   (${cubit.movie?.voteCount})",
                                    style: theme.textTheme.displayMedium
                                        ?.copyWith(fontSize: 14))
                              ],
                            ).setPadding(context, vertical: 0.05),
                          ],
                        ).setPadding(
                          context,
                          horizontal: 0.01,
                        ),
                      ],
                    ),
                    Text(
                      cubit.movie?.overview ?? "",
                      style: theme.textTheme.bodyMedium,
                    ).setPadding(context, vertical: 0.03),
                    Container(
                        color:const Color(0XFF282A28),
                        height: 260.h,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "More Like This",
                              style: theme.textTheme.headlineMedium,
                            ).setPadding(context,
                                horizontal: 0.02, vertical: 0.015),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 14),
                                            height: 140.h,
                                            width: 110.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0XFF282A28),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${Constants.imagePath}${cubit.similarMovies[index].posterPath}",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const ImageIcon(
                                                  AssetImage(
                                                      "assets/images/icons/star.png"),
                                                  size: 16,
                                                  color: Color(0XFFFFBB3B)),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                  "${cubit.similarMovies[index].voteAverage}",
                                                  style: theme
                                                      .textTheme.displayMedium
                                                      ?.copyWith(fontSize: 14))
                                            ],
                                          ),
                                          Text(
                                              cubit.similarMovies[index].title!
                                                          .length >
                                                      15
                                                  ? "${cubit.similarMovies[index].title!.substring(0, 15)}..."
                                                  : "${cubit.similarMovies[index].title}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: theme
                                                  .textTheme.displayMedium),
                                          Text(
                                              formatMovieDate(cubit
                                                  .similarMovies[index]
                                                  .releaseDate),
                                              style: theme.textTheme.bodySmall),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cubit.addMovieWatchList(cubit.similarMovies[index]);
                                        },
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                            ),
                                            color: Colors.grey,
                                            width: 24.w,
                                            height: 35.h,
                                            child: const Icon(Icons.add,
                                                color: Colors.white, size: 18),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                itemCount: cubit.similarMovies.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        )),
                  ],
                ).setPadding(context, horizontal: 0.02),
              ),
            );
          }),
    );
  }
}
