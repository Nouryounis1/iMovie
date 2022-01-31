import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/modules/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/modules/trending_movies/tending_movies_screen.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/components/skeleton.dart';
import 'package:movies_app/styles/colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(listener: (context, state) {
      if (MoviesCubit.get(context).popularMovies.isNotEmpty) {
        MoviesCubit.get(context).isLoading = false;
      }
    }, builder: (context, state) {
      var cubit = MoviesCubit.get(context);
      return Scaffold(
        backgroundColor: HexColor('15141F'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.center, children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: cubit.isLoading
                      ? const Skeleton(
                          height: 500.0,
                          width: double.infinity,
                        )
                      : Image.network(
                          cubit.img_path,
                          height: 500,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.2)),
                  ),
                ),
                Positioned(
                    child: CarouselSlider(
                        items: [
                      for (var i = 0; i < cubit.popularMovies.length; i++)
                        cubit.isLoading
                            ? const Skeleton(
                                height: 290.0,
                                width: 180.0,
                              )
                            : Container(
                                height: 290.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500/${cubit.popularMovies[i]['poster_path']}'),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    ),
                                  ],
                                ))
                    ],
                        options: CarouselOptions(
                          height: 280.0,
                          onPageChanged: (index, reason) {
                            cubit.changeIndexOfCarsouel(index);
                            cubit.img_path =
                                'https://image.tmdb.org/t/p/w500/${cubit.popularMovies[index]['poster_path']}';
                          },
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 2000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ))),
              ]),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Trending",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // NOTE: do something
                      },
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, TrendingMoviesScreen());
                        },
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28.0,
              ),
              SizedBox(
                height: 500.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 7,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return cubit.isLoading
                        ? popularMoviesLoadingItem()
                        : InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  MovieDetailsScreen(
                                    imgPath:
                                        'https://image.tmdb.org/t/p/w500/${cubit.popularMovies[index]['poster_path']}',
                                    moiveTitle: cubit.popularMovies[index]
                                        ['original_title'],
                                    movieId: cubit.popularMovies[index]['id'],
                                    data: MoviesCubit.get(context)
                                      ..getMoviesVideo(
                                          cubit.popularMovies[index]['id']),
                                    voteStar: cubit.popularMovies[index]
                                        ['vote_average'],
                                    relaseDate: cubit.popularMovies[index]
                                        ['release_date'],
                                    genres: cubit.popularMovies[index]
                                        ['genre_ids'],
                                  ));
                            },
                            child: popularMoviesItem(
                                cubit.popularMovies[index]['original_title'],
                                cubit.popularMovies[index]['poster_path'],
                                cubit.popularMovies[index]['vote_average']),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget popularMoviesItem(String title, String path, double rating) => SizedBox(
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [1, 2, 3, 4, 5].map((e) {
                return Icon(
                  Icons.star,
                  color: (e <= rating / 2) ? orangeColor : whiteColor,
                  size: 18,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
