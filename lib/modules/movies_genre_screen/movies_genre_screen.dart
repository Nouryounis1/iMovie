import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/modules/credit_movies_screen/credit_movie_screen.dart';
import 'package:movies_app/modules/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/shared/components/components.dart';

class MoviesGenreMovies extends StatefulWidget {
  final int genreId;
  const MoviesGenreMovies({Key? key, required this.genreId}) : super(key: key);

  @override
  State<MoviesGenreMovies> createState() => _MoviesGenreMoviesState();
}

class _MoviesGenreMoviesState extends State<MoviesGenreMovies> {
  List<dynamic> movies = [];

  @override
  void initState() {
    MoviesCubit.get(context).getgenresMovies(widget.genreId).then((value) {
      if (mounted) {
        if (MoviesCubit.get(context).genreMoviesss.isNotEmpty) {
          setState(() {
            movies = MoviesCubit.get(context).genreMoviesss;
            MoviesCubit.get(context).isLoadingGenreMovies = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: HexColor('15141F'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    movies = [];
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            ),
            backgroundColor: HexColor('15141F'),
            body: GridView.count(
              childAspectRatio: 1.45 / 2.2,
              crossAxisCount: 2,
              children: List.generate(movies.length, (index) {
                return InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        MovieDetailsScreen(
                          imgPath:
                              'https://image.tmdb.org/t/p/w500/${movies[index]['poster_path']}',
                          moiveTitle: movies[index]['original_title'],
                          movieId: movies[index]['id'],
                          data: MoviesCubit.get(context)
                            ..getMoviesVideo(movies[index]['id']),
                          voteStar: movies[index]['vote_average'],
                          relaseDate: movies[index]['release_date'],
                          genres: movies[index]['genre_ids'],
                          overview: movies[index]['overview'],
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: movies[index]['poster_path'] == null
                        ? creditLoadingItem()
                        : popularMoviesItem(movies[index]['poster_path']),
                  ),
                );
              }),
            ),
          );
        });
  }
}
