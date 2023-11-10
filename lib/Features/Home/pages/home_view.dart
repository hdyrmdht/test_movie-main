import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/Core/config/page_route_name.dart';
import 'package:movie/Core/constants/costants.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Features/Home/manager/cubit.dart';
import 'package:movie/Features/Home/manager/states.dart';

import '../../../Core/services/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = HomeCubit.get(context);
    // List<String?> paths =
    //     cubit.popularMovies.map((movie) => movie.backdropPath).toList();
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cubit.popularMovies.isNotEmpty
                    ? ImageSlideshow(
                        width: double.infinity,
                        height: 342.h,
                        initialPage: 0,
                        indicatorColor: Colors.transparent,
                        indicatorBackgroundColor: Colors.transparent,
                        indicatorPadding: 0,
                        indicatorBottomPadding: 0,
                        indicatorRadius: 0,
                        autoPlayInterval: 0,
                        isLoop: true,
                        children: cubit.popularMovies.map((movie) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${Constants.imagePath}${movie.backdropPath}",
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child: Icon(Icons
                                                      .movie_creation_outlined)),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 5.h),
                                      // Adjust the spacing as needed
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                          ),
                                          Text(
                                              //longText.length > maxLength ? longText.substring(0, maxLength) + "..." : longText;
                                              movie.title!.length > 40
                                                  ? "${movie.title!.substring(0, 40)}..."
                                                  : "${movie.title}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      // Adjust the spacing as needed
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                          ),
                                          Text(
                                              formatMovieDate(
                                                  movie.releaseDate),
                                              style: theme.textTheme.bodySmall),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cubit.addMovieWatchList(movie);
                                            },
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    color: Colors.grey),
                                                padding: EdgeInsets.all(5),
                                                child: Text("Add to WatchList",style: theme.textTheme.bodySmall?.copyWith(color: Colors.black)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: 199.h,
                                      width: 129.w,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, PageRouteName.movieDetails,
                                              arguments: movie.id);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "${Constants.imagePath}${movie.posterPath}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ).setPadding(context, horizontal: 0.05),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      )
                    : Container(),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                    color:  const Color(0XFF282A28), 
                    height: 222.h,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Releases",
                          style: theme.textTheme.headlineMedium,
                        ).setPadding(context, horizontal: 0.02, vertical: 0.02),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PageRouteName.movieDetails,
                                          arguments:
                                              cubit.newReleaseMovies[index].id);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 150.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0XFF282A28),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${Constants.imagePath}${cubit.newReleaseMovies[index].posterPath}",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.addMovieWatchList(
                                          cubit.newReleaseMovies[index]);
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 10,
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
                            itemCount: cubit.newReleaseMovies.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                    color:const Color(0XFF282A28),
                    height: 260.h,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recommended",
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              PageRouteName.movieDetails,
                                              arguments: cubit
                                                  .topRatedMovies[index].id);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 14),
                                          height: 140.h,
                                          width: 110.w,
                                          decoration: BoxDecoration(
                                            color: const Color(0XFF282A28),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${Constants.imagePath}${cubit.topRatedMovies[index].posterPath}",
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
                                              "${cubit.topRatedMovies[index].voteAverage}",
                                              style: theme
                                                  .textTheme.displayMedium
                                                  ?.copyWith(fontSize: 14))
                                        ],
                                      ),
                                      Text(
                                          cubit.topRatedMovies[index].title!
                                                      .length >
                                                  15
                                              ? "${cubit.topRatedMovies[index].title!.substring(0, 15)}..."
                                              : "${cubit.topRatedMovies[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: theme.textTheme.displayMedium),
                                      Text(
                                          formatMovieDate(cubit
                                              .topRatedMovies[index]
                                              .releaseDate),
                                          style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.addMovieWatchList(
                                          cubit.topRatedMovies[index]);
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
                            itemCount: cubit.topRatedMovies.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
                    )),
              ],
            ).setPadding(context, vertical: 0.02),
          );
        });
  }
}
