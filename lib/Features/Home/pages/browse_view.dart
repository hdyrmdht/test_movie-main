import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/Core/extentions/extentions.dart';
import 'package:movie/Features/Home/manager/states.dart';

import '../../../Core/config/page_route_name.dart';
import '../manager/cubit.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

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
              Text(
                "Browse Category ",
                style: theme.textTheme.headlineLarge,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageRouteName.moviesList,
                            arguments: cubit.movieCategories[index].id);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        width: 140.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/movie/${cubit.movieCategories[index].name}.jpeg"),
                              fit: BoxFit.cover),
                        ),
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.black.withOpacity(0.1),
                              child: Text(
                                "${cubit.movieCategories[index].name}",
                                style: theme.textTheme.headlineMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cubit.movieCategories.length,
                  scrollDirection: Axis.vertical,
                ),
              )
            ],
          ).setPadding(context, horizontal: 0.05, vertical: 0.025);
        });
  }
}
