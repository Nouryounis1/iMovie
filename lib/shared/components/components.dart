import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/shared/components/skeleton.dart';
import 'package:movies_app/styles/colors.dart';

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

Widget defaultFormField(
        {@required TextEditingController? controller,
        @required TextInputType? type,
        @required String? label,
        @required IconData? prefix,
        IconData? suffix,
        bool isPassword = false,
        @required String? validateText,
        dynamic onSubmmit,
        Function()? sufixPressed,
        bool isClicable = true}) =>
    TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      onFieldSubmitted: onSubmmit,
      validator: (value) {
        if (value!.isEmpty) {
          return validateText;
        }
        return null;
      },
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClicable,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor(primaryColor))),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          prefix,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
            color: Colors.white,
          ),
          onPressed: sufixPressed,
        ),
      ),
    );
