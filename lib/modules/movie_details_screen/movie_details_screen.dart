import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/models/moies_genre_model.dart';
import 'package:movies_app/modules/credit_movies_screen/credit_movie_screen.dart';
import 'package:movies_app/modules/movies_genre_screen/movies_genre_screen.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/styles/colors.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String imgPath;
  final String moiveTitle;
  final int movieId;
  final dynamic data;
  final double voteStar;
  final String relaseDate;
  final String overview;
  final List<dynamic> genres;
  const MovieDetailsScreen(
      {Key? key,
      required this.imgPath,
      required this.moiveTitle,
      required this.movieId,
      required this.voteStar,
      required this.relaseDate,
      required this.genres,
      required this.overview,
      required this.data})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

String? url;
List<String> genresName = [];
List<dynamic> genresId = [];

Map genreMap = Map<int, String>();

List<dynamic> casting = [];

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    MoviesCubit.get(context).getMoviesVideo(widget.movieId).then((value) {
      if (mounted) {
        setState(() {
          url = MoviesCubit.get(context).moviesVideos[0]['key'];
        });
      }
    });

    for (var i = 0; i <= MoviesCubit.get(context).genres.length - 1; i++)
      // ignore: curly_braces_in_flow_control_structures
      for (var j = 0; j <= widget.genres.length - 1; j++) {
        if (MoviesCubit.get(context).genres[i]['id'] == widget.genres[j]) {
          // genresName.add(MoviesCubit.get(context).genres[i]['name']);
          genreMap[MoviesCubit.get(context).genres[i]['id']] =
              MoviesCubit.get(context).genres[i]['name'];
        }
      }

    MoviesCubit.get(context).getCredits(widget.movieId).then((value) {
      if (mounted) {
        setState(() {
          casting = MoviesCubit.get(context).crediits;
        });
      }

      if (casting.isEmpty) {
        setState(() {
          MoviesCubit.get(context).isLoadingCredit = true;
        });
      } else {
        setState(() {
          MoviesCubit.get(context).isLoadingCredit = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesStates>(builder: (context, state) {
      YoutubePlayerController controller = YoutubePlayerController(
          initialVideoId:
              MoviesCubit.get(context).moviesVideos.isEmpty ? '' : url!,
          flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
      return Builder(builder: (context) {
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
                        widget.imgPath,
                        height: 500,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showAlertDialog(context, controller);
                      },
                      child: Container(
                        height: 102,
                        width: 102,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 80.0,
                          color: Color.fromRGBO(229, 9, 20, 1),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 70.0,
                        left: 10.0,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              genresName = [];
                              casting = [];
                              genreMap = {};
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 35.0,
                              color: Colors.white,
                            )))
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          widget.moiveTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 35,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: HexColor(primaryColor),
                              ),
                              Text(
                                '${widget.voteStar} (IMDB)',
                                style: const TextStyle(
                                    color: Colors.white, letterSpacing: 2),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: const Text(
                              'Release Date',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              widget.relaseDate,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 3.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.white30,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            child: const Text(
                              'Genre',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15.0),
                            width: 350.0,
                            child: Wrap(
                              spacing: 10.0,
                              children: [
                                //     for (var i in genresName)

                                for (var k in genreMap.keys)
                                  InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            MoviesGenreMovies(
                                              genreId: k,
                                            ));
                                      },
                                      child:
                                          Chip(label: Text('${genreMap[k]}'))),

                                const SizedBox(
                                  width: 10.0,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 0.5,
                      color: Colors.white30,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Text(
                      'Synopsis',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: ReadMoreText(
                      widget.overview,
                      trimLines: 3,
                      style: const TextStyle(height: 1.5, color: Colors.white),
                      colorClickableText: const Color.fromRGBO(229, 9, 20, 1),
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...Show more',
                      trimExpandedText: ' show less',
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Text(
                      'Cast',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 350.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: casting.length < 5 ? 3 : 5,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(width: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return casting.isEmpty
                            ? creditLoadingItem()
                            : InkWell(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      CreditMoviesScreen(
                                          creditId: casting[index]['id']));
                                },
                                child: creditMovieItem(
                                  casting[index]['name'],
                                  casting[index]['profile_path'],
                                ),
                              );
                      },
                    ),
                  ),
                ],
              )),
        );
      });
    });
  }
}

showAlertDialog(BuildContext context, controller) {
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    actionsPadding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    content: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: HexColor(primaryColor)),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
