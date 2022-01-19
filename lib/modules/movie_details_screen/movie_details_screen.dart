import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/styles/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String imgPath;
  final String moiveTitle;
  final int movieId;
  const MovieDetailsScreen(
      {Key? key,
      required this.imgPath,
      required this.moiveTitle,
      required this.movieId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesStates>(
        bloc: BlocProvider.of<MoviesCubit>(context)..getMoviesVideo(movieId),
        builder: (context, state) {
          YoutubePlayerController controller = YoutubePlayerController(
              initialVideoId: MoviesCubit.get(context).moviesVideos[0]['key'],
              flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
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
                          imgPath,
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
                            color: Colors.redAccent,
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        moiveTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ],
                )),
          );
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
