import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';

class TrendingMoviesScreen extends StatelessWidget {
  const TrendingMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(listener: (context, state) {
      if (MoviesCubit.get(context).popularMovies.isNotEmpty) {
        MoviesCubit.get(context).isLoading = false;
      }
    }, builder: (context, state) {
      var cubit = MoviesCubit.get(context);

      return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: HexColor('15141F'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
          backgroundColor: HexColor('15141F'),
          body: GridView.count(
            childAspectRatio: 1.45 / 2,
            crossAxisCount: 2,
            children: List.generate(cubit.popularMovies.length, (index) {
              return Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: popularMoviesItem(
                    cubit.popularMovies[index]['poster_path']),
              ));
            }),
          ));
    });
  }
}

Widget popularMoviesItem(String path) => SizedBox(
      height: 306,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/$path',
              width: 190,
              height: 250,
            ),
          ),
        ],
      ),
    );
