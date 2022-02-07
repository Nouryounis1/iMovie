import 'package:movies_app/API/api_constants.dart';

class Endpoints {
  static String discoverMoviesUrl(int page) {
    return '$API_BASE_URL'
        '/discover/movie?api_key='
        '$API_KEY'
        '&language=en-US&sort_by=popularity'
        '.desc&include_adult=false&include_video=false&page'
        '=$page';
  }

  static String getMovieVideo(int movieId) {
    return "$API_BASE_URL/movie/$movieId/videos?api_key=$API_KEY&language=en-US";
  }

  static String nowPlayingMoviesUrl(int page) {
    return '$API_BASE_URL'
        '/movie/now_playing?api_key='
        '$API_KEY'
        '&include_adult=false&page=$page';
  }

  static String getCreditsUrl(int id) {
    return '$API_BASE_URL' '/movie/$id/credits?api_key=$API_KEY';
  }

  static String getCreditsMovies(int id) {
    return '$API_BASE_URL'
        '/person/$id/movie_credits?api_key=$API_KEY'
        '&language=en-US';
  }

  static String topRatedUrl(int page) {
    return '$API_BASE_URL'
        '/movie/top_rated?api_key='
        '$API_KEY'
        '&include_adult=false&page=$page';
  }

  static String popularMoviesUrl(int page) {
    return '$API_BASE_URL'
        '/movie/popular?api_key='
        '$API_KEY'
        '&include_adult=false&page=$page';
  }

  static String upcomingMoviesUrl(int page) {
    return '$API_BASE_URL'
        '/movie/upcoming?api_key='
        '$API_KEY'
        '&include_adult=false&page=$page';
  }

  static String movieDetailsUrl(int movieId) {
    return '$API_BASE_URL/movie/$movieId?api_key=$API_KEY&append_to_response=credits,'
        'images';
  }

  static String genresUrl() {
    return '$API_BASE_URL/genre/movie/list?api_key=$API_KEY&language=en-US';
  }

  static String getMoviesForGenre(int genreId, int page) {
    return '$API_BASE_URL/discover/movie?api_key=$API_KEY'
        '&language=en-US'
        '&sort_by=popularity.desc'
        '&include_adult=false'
        '&include_video=false'
        '&page=$page'
        '&with_genres=$genreId';
  }

  static String movieReviewsUrl(int movieId, int page) {
    return '$API_BASE_URL/movie/$movieId/reviews?api_key=$API_KEY'
        '&language=en-US&page=$page';
  }

  static String movieSearchUrl(String query) {
    return "$API_BASE_URL/search/movie?query=$query&api_key=$API_KEY";
  }

  static String personSearchUrl(String query) {
    return "$API_BASE_URL/search/person?query=$query&api_key=$API_KEY";
  }

  static getPerson(int personId) {
    return "$API_BASE_URL/person/$personId?api_key=$API_KEY&append_to_response=movie_credits";
  }

  static getPersonPopular() {
    return "$API_BASE_URL/person/popular?api_key=$API_KEY&language=en-US&page=1";
  }
}
