import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Data/data_source/movies%20list/movies_list_datasource.dart';
import 'package:movie/Features/Movies%20List/manager/cubit.dart';
import 'package:movie/Features/Movies%20List/manager/states.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/constants/costants.dart';
import '../../../Core/services/utils.dart';

class MoviesListView extends StatelessWidget {
  int categoryId;

  MoviesListView(this.categoryId, {super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>
          MoviesListCubit(RemoteMovieListDto())..getMoviesList(categoryId),
      child: BlocConsumer<MoviesListCubit, MoviesListStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var mediaQuery = MediaQuery.of(context).size;
            var theme = Theme.of(context);
            var cubit = MoviesListCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: theme.backgroundColor,
                elevation: 0,
                title: Text("Movies", style: theme.textTheme.headlineLarge),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white, size: 22),
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, PageRouteName.movieDetails,
                          arguments: cubit.movies[index].id);
                    },
                    child: Container(
                      width: mediaQuery.width,
                      height: 110.h,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 100.h,
                                width: 140.w,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "${Constants.imagePath}${cubit.movies[index].posterPath}",
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
                              InkWell(
                                onTap: () {
                                  cubit.addMovieWatchList(
                                      cubit.movies[index]);
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5
                                    ),
                                    color: Colors.grey,
                                    width: 20.w,
                                    height: 31.h,
                                    child: const Icon(Icons.add,
                                        color: Colors.white, size: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  cubit.movies[index].title!
                                      .length >
                                      30
                                      ? "${cubit.movies[index].title!.substring(0, 30)}..."
                                      : "${cubit.movies[index].title}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: theme.textTheme.bodyLarge),
                              Text(
                                  formatMovieDate(cubit
                                      .movies[index]
                                      .releaseDate),
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
                                      "${cubit.movies[index].voteAverage}",
                                      style: theme
                                          .textTheme.displayMedium
                                          ?.copyWith(fontSize: 14))
                                ],
                              ),
                            ],
                          ).setPadding(context, horizontal: 0.01),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: cubit.movies.length,
              ),
            );
          }),
    );
  }
}
