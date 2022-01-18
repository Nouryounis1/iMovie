import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/styles/colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Stack(children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 80));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              'https://cdn.shopify.com/s/files/1/0969/9128/products/1917_-_Sam_Mendes_-_Hollywood_War_Film_Classic_English_Movie_Poster_1ca919ec-a5ae-4dae-8a4b-f116e321a5fa.jpg?v=1582781069',
              height: 500,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ]),
      ),
    );
  }
}
