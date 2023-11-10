import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/Core/error/faliure.dart';
import 'package:movie/Domain/entity/home/get_movie_entity.dart';
import 'package:movie/Domain/entity/home/movie_category_entity.dart';
import 'package:movie/Domain/use_case/home/get_movie_category_usecase.dart';
import 'package:movie/Domain/use_case/home/get_new_release_usecase.dart';
import 'package:movie/Domain/use_case/home/get_popular_usecase.dart';
import 'package:movie/Domain/use_case/home/get_top_rated_usecase.dart';
import 'package:movie/Domain/use_case/home/search_movie_usecase.dart';
import 'package:movie/Features/Home/manager/states.dart';
import 'package:movie/Features/Home/pages/browse_view.dart';
import 'package:movie/Features/Home/pages/search_view.dart';
import 'package:movie/Features/Home/pages/watchlist_view.dart';

import '../../../Data/data_source/home/home_datasource.dart';
import '../../../Data/model/home/get_movie_model.dart';
import '../../../Data/repository_imp/home/home_repositoy_imp.dart';
import '../../../Domain/entity/home/get_new_release_entity.dart';
import '../../../Domain/repository/home/home_repository.dart';
import '../pages/home_view.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeDataSource homeDataSource;
  late HomeRepository homeRepository;

  HomeCubit(this.homeDataSource) : super(HomeInitState()) {
    homeRepository = HomeRepositoryImp(homeDataSource);
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  TextEditingController searchQuery = TextEditingController();

  List<ResultsMovieEntity> popularMovies = [];
  List<ResultsMovieEntity> newReleaseMovies = [];
  DatesNewReleaseEntity? newRelease;
  List<ResultsMovieEntity> moviesWatchList = [];
  List<ResultsMovieEntity> topRatedMovies = [];
  List<ResultsMovieEntity> searchedMovies = [];
  List<GenresCategoryEntity> movieCategories = [];

  List<Widget> pages = [
    const HomeView(),
    const SearchView(),
    const BrowseView(),
    const WatchListView(),
  ];

  int currentIndex = 0;

  changeIndex(int v) {
    emit(HomeInitState());
    currentIndex = v;
    emit(ChangeCurrentIndexState());
  }

  getPopular() async {
    emit(GetPopularLoadingState());
    GetPopularUseCase getPopularUseCase = GetPopularUseCase(homeRepository);
    var result = await getPopularUseCase.execute();
    result.fold((l) {
      print(l.message);
      emit(GetPopularErrorState(l));
    }, (data) {
      popularMovies = data.results ?? [];
      emit(GetPopularSuccessState());
    });
  }

  getNewRelease() async {
    emit(GetNewReleaseLoadingState());
    GetNewReleaseUseCase getNewReleaseUseCase =
        GetNewReleaseUseCase(homeRepository);
    var result = await getNewReleaseUseCase.execute();
    result.fold((l) {
      print(l.message);
      emit(GetNewReleaseErrorState(l));
    }, (data) {
      newReleaseMovies = data.results ?? [];
      emit(GetNewReleaseSuccessState());
    });
  }

  getTopRated() async {
    emit(GetTopRatedLoadingState());
    GetTopRatedUseCase getTopRatedUseCase = GetTopRatedUseCase(homeRepository);
    var result = await getTopRatedUseCase.execute();
    result.fold((l) {
      print(l.message);
      emit(GetTopRatedErrorState(l));
    }, (data) {
      topRatedMovies = data.results ?? [];
      emit(GetTopRatedSuccessState());
    });
  }

  searchMovie() async {
    emit(SearchMovieLoadingState());
    SearchMovieUseCase searchMovieUseCase = SearchMovieUseCase(homeRepository);
    var result = await searchMovieUseCase.execute(searchQuery.text);
    result.fold((l) {
      print(l.message);
      emit(SearchMovieErrorState(l));
    }, (data) {
      searchedMovies = data.results ?? [];
      emit(SearchMovieSuccessState());
    });
  }

  getMovieCategory() async {
    emit(GetMovieCategoryLoadingState());
    GetMovieCategoryUseCase getMovieCategoryUseCase =
        GetMovieCategoryUseCase(homeRepository);
    var result = await getMovieCategoryUseCase.execute();
    result.fold((l) {
      print(l.message);
      emit(GetMovieCategoryErrorState(l));
    }, (data) {
      movieCategories = data.genres ?? [];
      emit(GetMovieCategorySuccessState());
    });
  }

  addMovieWatchList(ResultsMovieEntity movie) async {
    try {
      emit(AddWatchListLoadingState());
      CollectionReference movies =
          FirebaseFirestore.instance.collection('Movies');
      movie.user = FirebaseAuth.instance.currentUser?.email;
      await movies.add({
        "user": movie.user,
        "id": movie.id,
        "title": movie.title,
        "voteAverage": movie.voteAverage,
        "backdropPath": movie.backdropPath,
        "posterPath": movie.posterPath,
        "releaseDate": movie.releaseDate
      });
      getWatchList();
      emit(AddWatchListSuccessState());
    } on Exception catch (e) {
      emit(AddWatchListErrorState(ServerFailure(message: e.toString())));
    }
  }

  Future<void> getWatchList() async {
    try {
      emit(GetWatchListLoadingState());
      final currentUser = FirebaseAuth.instance.currentUser;
      final user = currentUser?.email;
      final movies = await FirebaseFirestore.instance
          .collection('Movies')
          .where('user', isEqualTo: user)
          .get();
      final watchList = movies.docs.map((doc) {
        return ResultsMovieEntity(
          id: doc['id'],
          title: doc['title'],
          voteAverage: doc['voteAverage'],
          backdropPath: doc['backdropPath'],
          posterPath: doc['posterPath'],
          releaseDate: doc['releaseDate'],
        );
      }).toList();
      moviesWatchList = watchList;
      emit(GetWatchListSuccessState());
    } catch (e) {
      print("erroorrrrrrrrrrrrrrrrrr $e");
      emit(GetWatchListErrorState(ServerFailure(message: e.toString())));
    }
  }

  Future<void> deleteMovieFromWatchList(int movieId) async {
    try {
      emit(DeleteWatchListLoadingState());
      final email = FirebaseAuth.instance.currentUser?.email;
      final movies = await FirebaseFirestore.instance
          .collection('Movies')
          .where('user', isEqualTo: email)
          .where('id', isEqualTo: movieId)
          .get();
      for (var doc in movies.docs) {
        await doc.reference.delete();
      }
      getWatchList();
      emit(DeleteWatchListSuccessState());
    } catch (e) {
      emit(DeleteWatchListErrorState(ServerFailure(message: e.toString())));
    }
  }
  logout()async{
   try {
     emit(LogOutLoadingState());
     await FirebaseAuth.instance.signOut();
     emit(LogOutSuccessState());
   } on FirebaseException catch (e) {
     emit(LogOutErrorState(ServerFailure(message: e.message)));
   }
  }
}
