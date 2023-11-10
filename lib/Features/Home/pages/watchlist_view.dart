import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';
import 'package:movie/Features/Home/manager/cubit.dart';
import 'package:movie/Features/Home/manager/states.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/constants/costants.dart';
import '../../../Core/services/utils.dart';

class WatchListView extends StatefulWidget {
  const WatchListView({super.key});

  @override
  State<WatchListView> createState() => _WatchListViewState();
}

class _WatchListViewState extends State<WatchListView> {
  @override
  void initState() {
    HomeCubit.get(context).getWatchList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Watchlist",
                    style: theme.textTheme.headlineLarge,
                  ),
                  IconButton(onPressed: () {
                    cubit.logout();
                  }, icon: Icon(Icons.logout),color: Colors.white,)
                ],
              ).setOnlyPadding(context, top: 0.02),
              cubit.moviesWatchList.isNotEmpty
                  ? Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          width: mediaQuery.width,
                          height: 110.h,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PageRouteName.movieDetails,
                                      arguments:
                                          cubit.moviesWatchList[index].id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 130.h,
                                  width: 160.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${Constants.imagePath}${cubit.moviesWatchList[index].posterPath}",
                                      fit: BoxFit.fill,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      cubit.moviesWatchList[index].title!
                                                  .length >
                                              30
                                          ? "${cubit.moviesWatchList[index].title!.substring(0, 28)}..."
                                          : "${cubit.moviesWatchList[index].title}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: theme.textTheme.bodyLarge),
                                  Text(
                                      formatMovieDate(cubit
                                          .moviesWatchList[index].releaseDate),
                                      style: theme.textTheme.bodySmall),
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
                                          "${cubit.moviesWatchList[index].voteAverage}",
                                          style: theme.textTheme.displayMedium
                                              ?.copyWith(fontSize: 14))
                                    ],
                                  ),
                                ],
                              ).setPadding(context, horizontal: 0.01),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.deleteMovieFromWatchList(
                                cubit.moviesWatchList[index].id ?? 0);
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: theme.primaryColor,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              width: 24.w,
                              height: 35.h,
                              child: const Icon(Icons.check,
                                  color: Colors.white, size: 19),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: cubit.moviesWatchList.length,
                ),
              )
                  : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/icons/nomovies.png"),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "No Movies In Your WatchList ...",
                      style: theme.textTheme.bodyMedium,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}
