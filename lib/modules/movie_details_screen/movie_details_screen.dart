import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/styles/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String imgPath;
  final String moiveTitle;
  final int movieId;
  final dynamic data;
  final double voteStar;
  final String relaseDate;
  final List<dynamic> genres;
  const MovieDetailsScreen(
      {Key? key,
      required this.imgPath,
      required this.moiveTitle,
      required this.movieId,
      required this.voteStar,
      required this.relaseDate,
      required this.genres,
      required this.data})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

String? url;
List<String> genresName = [];

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
          genresName.add(MoviesCubit.get(context).genres[i]['name']);
        }
      }
    print(genresName);
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
                        Row(
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                            height: 10.0,
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
                            padding: EdgeInsets.only(left: 15.0),
                            width: 350.0,
                            child: Wrap(
                              spacing: 10.0,
                              children: [
                                for (var i in genresName)
                                  Chip(label: Text(i.toString())),
                                SizedBox(
                                  width: 10.0,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
