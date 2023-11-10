import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/Data/data_source/movies%20list/movies_list_datasource.dart';
import 'package:movie/Data/repository_imp/movies%20list/movies_list_repository_imp.dart';
import 'package:movie/Domain/repository/movies%20list/movies_list_repository.dart';
import 'package:movie/Domain/use_case/movies%20list/get_movies_list_usecase.dart';
import 'package:movie/Features/Movies%20List/manager/states.dart';

import '../../../Core/error/faliure.dart';
import '../../../Domain/entity/home/get_movie_entity.dart';

class MoviesListCubit extends Cubit<MoviesListStates> {
  MoviesListDataSource moviesListDatasource;
  late MoviesListRepository moviesListRepository;

  MoviesListCubit(this.moviesListDatasource) : super(MoviesListInitState()) {
    moviesListRepository = MoviesListRepositoryImp(moviesListDatasource);
  }

  List<ResultsMovieEntity> movies = [];

  static MoviesListCubit get(context) => BlocProvider.of(context);

  getMoviesList(int genreId) async {
    emit(GetMoviesListLoadingState());
    GetMovieListUseCase movieListUseCase = GetMovieListUseCase(moviesListRepository);
    var result = await movieListUseCase.execute(genreId);
    result.fold((l) {
      print(l.message);
      emit(GetMoviesListErrorState(l));
    }, (data) {
      movies = data.results??[] ;
      emit(GetMoviesListSuccessState());
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
      emit(AddWatchListSuccessState());
    } on Exception catch (e) {
      emit(AddWatchListErrorState(ServerFailure(message: e.toString())));
    }
  }
}
