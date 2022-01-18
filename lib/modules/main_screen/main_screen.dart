import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                      child: Image.network(
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
                            Container(
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
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ))),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          'Trending',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.white70,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, top: 6.0),
                        child: Text(
                          'See All',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Container(
                    height: 500.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: 7,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return trendingItem(
                            cubit.popularMovies[index]['original_title'],
                            cubit.popularMovies[index]['poster_path']);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(
                      'Trending',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 34.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget trendingItem(String name, String path) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Container(
              height: 270.0,
              width: 180.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage('https://image.tmdb.org/t/p/w500/${path}'),
                  fit: BoxFit.fill,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),

                    spreadRadius: 1,

                    blurRadius: 1,

                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 15.0),
          child: Text(
            name,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 10.0),
          child: stars,
        ),
      ],
    );

Widget stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.yellow[600]),
    Icon(Icons.star, color: Colors.yellow[600]),
    Icon(Icons.star_border, color: Colors.yellow[600]),
    Icon(Icons.star_border, color: Colors.yellow[600]),
    Icon(Icons.star_border, color: Colors.yellow[600]),
  ],
);
