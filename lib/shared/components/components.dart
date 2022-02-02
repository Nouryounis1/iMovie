import 'package:flutter/material.dart';
import 'package:movies_app/shared/components/skeleton.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget popularMoviesLoadingItem() => SizedBox(
      height: 306,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Skeleton(
              width: 190,
              height: 250,
              radius: 20.0,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Skeleton(
              width: 190,
              height: 10,
            ),
          ),
          SizedBox(height: 7),
          Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Skeleton(
                width: 100,
                height: 10,
              ))
        ],
      ),
    );

Widget creditMoviesLoadingItem() => SizedBox(
      height: 306,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Skeleton(
              width: 190,
              height: 250,
              radius: 20.0,
            ),
          ),
        ],
      ),
    );

Widget creditLoadingItem() => SizedBox(
      height: 306,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Skeleton(
              width: 190,
              height: 250,
              radius: 20.0,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Skeleton(
              width: 190,
              height: 10,
            ),
          ),
        ],
      ),
    );

Widget creditMovieItem(String title, String path) => SizedBox(
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
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
