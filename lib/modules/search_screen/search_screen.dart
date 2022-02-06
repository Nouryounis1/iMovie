import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/state.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/styles/colors.dart';

// ignore: must_be_immutable
class SerachScreen extends StatelessWidget {
  SerachScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchContoller = TextEditingController();

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
                        height: 300.0,
                        child: TabBarView(children: [
                          Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: TextField(
                                          cursorColor: HexColor(primaryColor),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          onChanged: (String? value) {
                                            if (value!.isNotEmpty) {
                                              MoviesCubit.get(context)
                                                  .changeValueOfSearchBar(true);
                                            } else {
                                              MoviesCubit.get(context)
                                                  .changeValueOfSearchBar(
                                                      false);
                                            }
                                          },
                                          controller: searchContoller,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Movie Name',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade300),
                                              suffixIcon:
                                                  MoviesCubit.get(context)
                                                          .searchValue
                                                      ? IconButton(
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            searchContoller
                                                                .clear();
                                                          },
                                                        )
                                                      : Container(
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
                                height: 10.0,
                              ),
                            ],
                          ),
                          Text('data')
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
}
