import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/API/Endpoints.dart';
import 'package:movies_app/API/api_constants.dart';
import 'package:movies_app/API/dio_helper.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/models/movies_model.dart';
import 'package:movies_app/modules/discover_screen/discover_screen.dart';
import 'package:movies_app/modules/main_screen/main_screen.dart';
import 'package:movies_app/modules/search_screen/search_screen.dart';
import 'package:movies_app/shared/logs.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesInitalState());
  static MoviesCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  int currentIndexCarsouel = 0;
  Movies? moviesModel;
  List<dynamic> popularMovies = [];

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

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  Future<Movies?> getPlaces() async {
    Movies? movies;

    try {
      Response userData = await _dio.get(Endpoints.popularMoviesUrl(1));

      //  print('User Info: ${userData.data}');
      popularMovies = userData.data['results'];
      print(popularMovies[0]['original_title'] + 'eeeeeeeeee');

      // /  place = Places.fromJson(userData.data);
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

  void getPopularMovies() {
    emit(MoviesLoadingPopularMoviesDataState());

    DioHelper.getData(url: Endpoints.popularMoviesUrl(1)).then((value) {
      moviesModel = Movies.fromJson(value.data);
      print(moviesModel);
      moviesModel!.results!.forEach((element) {
        print(element);
      });

      emit(MoviesSuccessPopularMoviesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(MoviesErorPopularMoviesDataState());
    });
  }
}
