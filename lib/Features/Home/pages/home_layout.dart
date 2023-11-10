import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/Core/config/page_route_name.dart';
import 'package:movie/Data/data_source/home/home_datasource.dart';
import 'package:movie/Features/Home/manager/cubit.dart';
import 'package:movie/Features/Home/manager/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(RemoteHomeDto())
        ..getPopular()
        ..getNewRelease()
        ..getTopRated()
        ..getMovieCategory()
      ..getWatchList(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is LogOutSuccessState){
            Navigator.pushNamedAndRemoveUntil(context, PageRouteName.login, (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            body: cubit.pages[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items:  [
                BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/icons/home.png")), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/icons/browse.png")), label: "Browse"),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/icons/watchlist.png")), label: "WatchList"),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeIndex(value);
              },
            ),
          );
        },
      ),
    );
  }
}
