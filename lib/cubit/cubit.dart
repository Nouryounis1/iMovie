import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/API/Endpoints.dart';
import 'package:movies_app/API/api_constants.dart';
import 'package:movies_app/API/dio_helper.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/models/credit_movies_model.dart';
import 'package:movies_app/models/geners_model.dart';
import 'package:movies_app/models/moies_genre_model.dart';
import 'package:movies_app/models/movie_credit_model.dart';
import 'package:movies_app/models/movies_model.dart';
import 'package:movies_app/models/movies_video_model.dart';
import 'package:movies_app/modules/discover_screen/discover_screen.dart';
import 'package:movies_app/modules/main_screen/main_screen.dart';
import 'package:movies_app/modules/search_screen/search_screen.dart';
import 'package:movies_app/shared/logs.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitalState());
  static MoviesCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int currentIndexCarsouel = 0;
  Movies? moviesModel;
  List<dynamic> popularMovies = [];
  List<dynamic> moviesVideos = [];
  List<dynamic> genres = [];
  List<dynamic> crediits = [];
  List<dynamic> creditMoviess = [];
  List<dynamic> genreMoviesss = [];

  bool isLoading = true;
  bool isVideoLoading = true;
  bool isLoadingCredit = true;
  bool isLoadingCreditMovies = true;
  bool isLoadingGenreMovies = true;
  String videoUrl = ''; // This for your video id's

  String img_path = '';

  List<Widget> bottomScreens = [
    const MainScreen(),
    const DiscoverScreen(),
    const SerachScreen()
  ];

  void changeIndexOfCarsouel(int index) {
    currentIndexCarsouel = index;
    emit(MoviesChangeCarsouelIndexState());
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(MoviesChangeBottomNavState());
  }

  String changeUrl() {
    videoUrl = moviesVideos[0]['key'];
    emit(MoviesCheckVideoUrlState());
    return videoUrl;
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  Future<MoviesVideo?> getMoviesVideo(int movieId) async {
    MoviesVideo? moviesVideo;

    try {
      Response userData = await _dio.get(Endpoints.getMovieVideo(movieId));

      moviesVideos = userData.data['results'];

      print(videoUrl);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return moviesVideo;
  }

  Future<Movies?> getPopularMovies() async {
    Movies? movies;

    try {
      Response userData = await _dio.get(Endpoints.popularMoviesUrl(1));

      popularMovies = userData.data['results'];

      print(popularMovies[0]['original_title'] + 'eeeeeeeeee');
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return movies;
  }

  Future<MovieGenre?> getGenres() async {
    MovieGenre? generess;

    try {
      Response userData = await _dio.get(Endpoints.genresUrl());

      genres = userData.data['genres'];

      print(genres);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return generess;
  }

  Future<MovieCredit?> getCredits(int id) async {
    MovieCredit? credits;

    try {
      Response userData = await _dio.get(Endpoints.getCreditsUrl(id));

      crediits = userData.data['cast'];

      print(crediits[0]);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return credits;
  }

  Future<CreditMovies?> getCreditsMovies(int id) async {
    CreditMovies? creditMovies;

    try {
      Response userData = await _dio.get(Endpoints.getCreditsMovies(id));

      creditMoviess = userData.data['cast'];

      print(creditMoviess[0]['poster_path']);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return creditMovies;
  }

  Future<GenreMovies?> getgenresMovies(int id) async {
    GenreMovies? genreMovies;

    try {
      Response userData = await _dio.get(Endpoints.getMoviesForGenre(id, 1));

      genreMoviesss = userData.data['results'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return genreMovies;
  }
}
