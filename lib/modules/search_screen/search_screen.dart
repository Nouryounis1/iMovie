import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/speech_api/speech_api.dart';
import 'package:movies_app/styles/colors.dart';
import 'package:speech_to_text/speech_to_text.dart';

// ignore: must_be_immutable
class SerachScreen extends StatefulWidget {
  SerachScreen({Key? key}) : super(key: key);

  @override
  State<SerachScreen> createState() => _SerachScreenState();
}

SpeechToText speechToText = SpeechToText();

bool isListening = false;
String voiceText = '';
double voiceConfidence = 1.0;
bool _speechEnabled = false;
late FocusNode myFocusNode;

class _SerachScreenState extends State<SerachScreen> {
  var formKey = GlobalKey<FormState>();

  var searchContoller = TextEditingController();

  var searchContoller2 = TextEditingController();
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    myFocusNode = FocusNode();
  }

  void _initSpeech() async {
    _speechEnabled = await speechToText.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    searchContoller.dispose();
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: HexColor('15141F'),
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();

                    MoviesCubit.get(context).movieSearch = [];
                  },
                ),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                            color: HexColor('201e2f'),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: TabBar(
                            indicator: BoxDecoration(
                                color: HexColor(primaryColor),
                                borderRadius: BorderRadius.circular(8.0)),
                            tabs: const [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Movies",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Persons",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 500.0,
                        child: TabBarView(children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8.0),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(50, 255, 255, 255),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22.0)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Stack(
                                            children: [
                                              TextFormField(
                                                autofocus: true,
                                                focusNode: myFocusNode,
                                                textInputAction:
                                                    TextInputAction.go,
                                                cursorColor:
                                                    HexColor(primaryColor),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                onFieldSubmitted:
                                                    (String value) {
                                                  if (searchContoller
                                                      .text.isNotEmpty) {
                                                    searchContoller.selection =
                                                        TextSelection.fromPosition(
                                                            TextPosition(
                                                                offset:
                                                                    searchContoller
                                                                        .text
                                                                        .length));
                                                  }
                                                  MoviesCubit.get(context)
                                                      .getMovieSearch(value);
                                                  if (value.isNotEmpty) {
                                                    MoviesCubit.get(context)
                                                        .changeValueOfSearchBarMovie(
                                                            true);
                                                  } else {
                                                    MoviesCubit.get(context)
                                                        .changeValueOfSearchBarMovie(
                                                            false);
                                                    MoviesCubit.get(context)
                                                        .movieSearch = [];
                                                  }
                                                },
                                                onChanged: (String value) {
                                                  MoviesCubit.get(context)
                                                      .getMovieSearch(value);
                                                  if (value.isNotEmpty) {
                                                    MoviesCubit.get(context)
                                                        .changeValueOfSearchBarMovie(
                                                            true);
                                                  } else {
                                                    MoviesCubit.get(context)
                                                        .changeValueOfSearchBarMovie(
                                                            false);
                                                    MoviesCubit.get(context)
                                                        .movieSearch = [];
                                                  }
                                                },
                                                controller: searchContoller,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                      top: 14,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: isListening
                                                        ? ''
                                                        : 'Movie Name',
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .grey.shade300),
                                                    suffixIcon: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        GestureDetector(
                                                          onLongPressDown: (_) {
                                                            searchContoller
                                                                .text = '';
                                                            toggleRecording();

                                                            if (searchContoller
                                                                .text
                                                                .isNotEmpty) {
                                                              TextSelection.fromPosition(
                                                                  TextPosition(
                                                                      offset: searchContoller
                                                                          .text
                                                                          .length));
                                                            }
                                                          },
                                                          onLongPressUp: () {},
                                                          child:
                                                              FloatingActionButton(
                                                            elevation: 0.0,
                                                            onPressed: () {},
                                                            mini: true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            child: const Icon(
                                                                Icons.mic),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        searchContoller
                                                                .text.isNotEmpty
                                                            ? IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed: () {
                                                                  searchContoller
                                                                      .clear();
                                                                  MoviesCubit.get(
                                                                          context)
                                                                      .changeValueOfSearchBarMovie(
                                                                          false);
                                                                  MoviesCubit.get(
                                                                          context)
                                                                      .movieSearch = [];
                                                                },
                                                              )
                                                            : const SizedBox(
                                                                height: 0,
                                                                width: 0,
                                                              ),
                                                      ],
                                                    ),
                                                    prefixIcon: const Icon(
                                                      Icons.search,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                              Positioned(
                                                top: 10,
                                                left: 50,
                                                child: isListening
                                                    ? DefaultTextStyle(
                                                        style: const TextStyle(
                                                          fontSize: 20.0,
                                                        ),
                                                        child: AnimatedTextKit(
                                                          animatedTexts: [
                                                            WavyAnimatedText(
                                                                '. . .'),
                                                          ],
                                                          isRepeatingAnimation:
                                                              true,
                                                        ),
                                                      )
                                                    : Container(),
                                              )
                                            ],
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                if (MoviesCubit.get(context)
                                    .movieSearch
                                    .isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Recommendations  ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 180,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                            'https://image.tmdb.org/t/p/w500/'
                                                            '${MoviesCubit.get(context).nowPlayingMovies[index]['poster_path']}',
                                                            width: 130,
                                                            height: 180,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 150.0,
                                                              child: Text(
                                                                MoviesCubit.get(
                                                                            context)
                                                                        .nowPlayingMovies[index]
                                                                    [
                                                                    'original_title'],
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: HexColor(
                                                                            primaryColor),
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            3.0,
                                                                      ),
                                                                      Text(
                                                                        '${MoviesCubit.get(context).nowPlayingMovies[index]['vote_average'].toString()} (IMDB)',
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                2),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5.0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              width: 150.0,
                                                              child: Wrap(
                                                                children: [
                                                                  for (var k in MoviesCubit.get(
                                                                              context)
                                                                          .nowPlayingMovies[index]
                                                                      [
                                                                      'genre_ids'])
                                                                    Text(
                                                                      '${MoviesCubit.get(context).map1[k]}   ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              12.0,
                                                                          height:
                                                                              2),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                            itemCount: 10),
                                      ],
                                    ),
                                  ),
                                if (state is SearchSuccessState)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 180,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: MoviesCubit.get(context)
                                                                            .movieSearch[index]
                                                                        [
                                                                        'poster_path'] ==
                                                                    null
                                                                ? const FadeInImage(
                                                                    width: 130,
                                                                    height: 180,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    placeholder:
                                                                        AssetImage(
                                                                            'assets/placeholder.jpg'),
                                                                    image: AssetImage(
                                                                        'assets/placeholder.jpg'))
                                                                : FadeInImage(
                                                                    width: 130,
                                                                    height: 180,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    placeholder:
                                                                        const AssetImage(
                                                                            'assets/placeholder.jpg'),
                                                                    image: NetworkImage(
                                                                        'https://image.tmdb.org/t/p/w500/${MoviesCubit.get(context).movieSearch[index]['poster_path']}'))),
                                                        const SizedBox(
                                                            width: 15),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 150.0,
                                                              child: Text(
                                                                MoviesCubit.get(
                                                                            context)
                                                                        .movieSearch[index]
                                                                    [
                                                                    'original_title'],
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: HexColor(
                                                                            primaryColor),
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            3.0,
                                                                      ),
                                                                      Text(
                                                                        '${MoviesCubit.get(context).movieSearch[index]['vote_average'].toString()} (IMDB)',
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                2),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5.0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              width: 150.0,
                                                              child: Wrap(
                                                                children: [
                                                                  for (var k in MoviesCubit.get(
                                                                              context)
                                                                          .movieSearch[index]
                                                                      [
                                                                      'genre_ids'])
                                                                    Text(
                                                                      '${MoviesCubit.get(context).map1[k]}   ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              12.0,
                                                                          height:
                                                                              2),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                            itemCount: MoviesCubit.get(context)
                                                .movieSearch
                                                .length),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8.0),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(50, 255, 255, 255),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22.0)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            cursorColor: HexColor(primaryColor),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            onChanged: (String value) {
                                              MoviesCubit.get(context)
                                                  .getMovieSearch(value);
                                              if (value.isNotEmpty) {
                                                MoviesCubit.get(context)
                                                    .changeValueOfSearchBarPerson(
                                                        true);
                                              } else {
                                                MoviesCubit.get(context)
                                                    .changeValueOfSearchBarPerson(
                                                        false);
                                                MoviesCubit.get(context)
                                                    .movieSearch = [];
                                              }
                                            },
                                            controller: searchContoller2,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  top: 14,
                                                ),
                                                border: InputBorder.none,
                                                hintText: 'Person Name',
                                                hintStyle: TextStyle(
                                                    color:
                                                        Colors.grey.shade300),
                                                suffixIcon:
                                                    MoviesCubit.get(context)
                                                            .searchValue
                                                        ? IconButton(
                                                            icon: const Icon(
                                                              Icons.cancel,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed: () {
                                                              searchContoller2
                                                                  .clear();
                                                              MoviesCubit.get(
                                                                      context)
                                                                  .changeValueOfSearchBarPerson(
                                                                      false);
                                                              MoviesCubit.get(
                                                                      context)
                                                                  .movieSearch = [];
                                                            },
                                                          )
                                                        : const SizedBox(
                                                            height: 0,
                                                            width: 0,
                                                          ),
                                                prefixIcon: const Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Popular  ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                width: 180,
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: MoviesCubit.get(
                                                                          context)
                                                                      .popularPersons[index]
                                                                  [
                                                                  'profile_path'] ==
                                                              null
                                                          ? searchImageLoadingItem()
                                                          : Image.network(
                                                              'https://image.tmdb.org/t/p/w500/'
                                                              '${MoviesCubit.get(context).popularPersons[index]['profile_path']}',
                                                              width: 130,
                                                              height: 190,
                                                              fit: BoxFit.fill,
                                                            ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 150.0,
                                                          child: Text(
                                                            MoviesCubit.get(
                                                                        context)
                                                                    .popularPersons[
                                                                index]['name'],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Row(
                                                          children: [
                                                            MoviesCubit.get(context)
                                                                            .popularPersons[index]
                                                                        [
                                                                        'popularity'] <
                                                                    70
                                                                ? const Icon(
                                                                    Icons
                                                                        .trending_down,
                                                                    color: Colors
                                                                        .redAccent,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .trending_up,
                                                                    color: Colors
                                                                        .greenAccent,
                                                                  ),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Text(
                                                              '${(MoviesCubit.get(context).popularPersons[index]['popularity'] / 10).toStringAsFixed(2)} %',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      2),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                            itemCount: 10)
                                      ]),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => searchContoller.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);
        },
      );
}
