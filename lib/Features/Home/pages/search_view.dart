import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Features/Home/manager/cubit.dart';
import 'package:movie/Features/Home/manager/states.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/constants/costants.dart';
import '../../../Core/services/utils.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  //cubit.searchQuery.text = value;
                  cubit.searchMovie();
                },
                controller: cubit.searchQuery,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.7),
                  ),
                  fillColor:const Color(0XFF282A28),
                  filled: true,
                  hintText: "Search",
                  hintStyle: theme.textTheme.bodyLarge,
                  suffixIcon: IconButton(
                    onPressed: () {
                      // cubit.searchMovie();
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              )
                  .setPadding(context, horizontal: 0.03)
                  .setOnlyPadding(context, top: 0.04, bottom: 0.01),
              cubit.searchedMovies.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageRouteName.movieDetails,
                                  arguments: cubit.searchedMovies[index].id);
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
                                            "${Constants.imagePath}${cubit.searchedMovies[index].posterPath}",
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
                                              cubit.searchedMovies[index]);
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
                                          cubit.searchedMovies[index].title!
                                                      .length >
                                                  30
                                              ? "${cubit.searchedMovies[index].title!.substring(0, 30)}..."
                                              : "${cubit.searchedMovies[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: theme.textTheme.bodyLarge),
                                      Text(
                                          formatMovieDate(cubit
                                              .searchedMovies[index]
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
                                              "${cubit.searchedMovies[index].voteAverage}",
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
                        itemCount: cubit.searchedMovies.length,
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
                            "No movies found",
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
