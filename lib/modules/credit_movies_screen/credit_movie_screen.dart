import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/modules/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/shared/components/components.dart';

class CreditMoviesScreen extends StatefulWidget {
  final int creditId;
  const CreditMoviesScreen({Key? key, required this.creditId})
      : super(key: key);

  @override
  State<CreditMoviesScreen> createState() => _CreditMoviesScreenState();
}

List<dynamic> movies = [];

class _CreditMoviesScreenState extends State<CreditMoviesScreen> {
  @override
  void initState() {
    MoviesCubit.get(context).getCreditsMovies(widget.creditId).then((value) {
      if (mounted) {
        if (MoviesCubit.get(context).creditMoviess.isNotEmpty) {
          setState(() {
            movies = MoviesCubit.get(context).creditMoviess;
            MoviesCubit.get(context).isLoading = false;
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
          var cubit = MoviesCubit.get(context);

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
              ));
        });
  }
}

Widget popularMoviesItem(String path) => SizedBox(
      height: 326,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: path == 'null'
                ? creditLoadingItem()
                : Image.network(
                    'https://image.tmdb.org/t/p/w500/$path',
                    width: 190,
                    height: 250,
                  ),
          ),
        ],
      ),
    );
