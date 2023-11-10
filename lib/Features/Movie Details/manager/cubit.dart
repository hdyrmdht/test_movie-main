import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/Data/data_source/movie%20details/movie_details_datasource.dart';
import 'package:movie/Data/repository_imp/movie%20details/movie_details_repository_imp.dart';
import 'package:movie/Domain/entity/movie%20details/movie_details_entity.dart';
import 'package:movie/Domain/repository/movie%20details/movies_details_repository.dart';
import 'package:movie/Domain/use_case/movie%20details/movie_details_usecase.dart';
import 'package:movie/Domain/use_case/movie%20details/similar_movies_usecase.dart';
import 'package:movie/Features/Movie%20Details/manager/states.dart';

import '../../../Core/error/faliure.dart';
import '../../../Domain/entity/home/get_movie_entity.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsDatasource movieDetailsDatasource;
  late MovieDetailsRepository movieDetailsRepository;

  MovieDetailsCubit(this.movieDetailsDatasource)
      : super(MovieDetailsInitState()) {
    movieDetailsRepository = MovieDetailsRepositoryImp(movieDetailsDatasource);
  }
  List<ResultsMovieEntity> similarMovies = [];
    MovieDetailsEntity? movie;

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  getMovieDetails(int movieId) async {
    emit(GetMovieDetailsLoadingState());
    MovieDetailsUseCase movieDetailsUseCase =
        MovieDetailsUseCase(movieDetailsRepository);
    var result = await movieDetailsUseCase.execute(movieId);
    result.fold((l) {
      print(l.message);
      emit(GetMovieDetailsErrorState(l));
    }, (data) {
      movie = data ;
      emit(GetMovieDetailsSuccessState());
    });
  }

  getSimilarMovies(int movieId) async {
    emit(GetSimilarMoviesLoadingState());
    SimilarMoviesUseCase similarMoviesUseCase = SimilarMoviesUseCase(movieDetailsRepository);
    var result = await similarMoviesUseCase.execute(movieId);
    result.fold((l) {
      print(l.message);
      emit(GetSimilarMoviesErrorState(l));
    }, (data) {
      similarMovies = data.results??[] ;
      emit(GetSimilarMoviesSuccessState());
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
