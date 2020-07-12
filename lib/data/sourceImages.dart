import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/util/SourceImage.dart';
import 'package:flutter/material.dart';

//Photo by David Bartus from Pexels
List<SourceImage> sourceImages = [
  SourceImage(
    imagePath: "assets/images/abandoned-forest.jpg",
    author: "Snapwire",
    url: "https://www.pexels.com/photo/abandoned-forest-industry-nature-34950/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(18, 59, 0, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(42, 166, 32, 1)),
        position: 0.4,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(102, 144, 49, 1)),
        position: 0.5,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(42, 128, 13, 1)),
        position: 0.64,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(43, 93, 22, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/nature-red-forest-leaves.jpg",
    author: "Pixabay",
    url: "https://www.pexels.com/photo/nature-red-forest-leaves-33109/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(201, 22, 0, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(226, 160, 51, 1)),
        position: 0.48,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(184, 92, 29, 1)),
        position: 0.7,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(152, 25, 3, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/daylight-forest-glossy-lake.jpg",
    author: "eberhard grossgasteiger",
    url: "https://www.pexels.com/photo/daylight-forest-glossy-lake-443446/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(0, 250, 255, 1)),
        position: 0.07,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(245, 255, 255, 1)),
        position: 0.19,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(149, 223, 244, 1)),
        position: 0.3,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(0, 211, 255, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/nature-bird-red-wildlife.jpg",
    author: "Pixabay",
    url: "https://www.pexels.com/photo/nature-bird-red-wildlife-36762/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(0, 255, 13, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 0, 10, 1)),
        position: 0.15,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 4, 0, 1)),
        position: 0.85,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(0, 255, 13, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/clouds-countryside-daylight-field.jpg",
    author: "David Bartus",
    url:
        "https://www.pexels.com/photo/clouds-countryside-daylight-field-404966/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(249, 238, 6, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(83, 156, 246, 1)),
        position: 0.77,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/northern-lights-over-mountain.jpg",
    author: "stein egil liland",
    url: "https://www.pexels.com/photo/northern-lights-over-mountain-3374208/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(88, 3, 255, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(29, 61, 73, 1)),
        position: 0.12,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(1, 151, 37, 1)),
        position: 0.28,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(29, 61, 73, 1)),
        position: 0.48,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(88, 3, 255, 1)),
        position: 0.64,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(29, 61, 73, 1)),
        position: 0.83,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(3, 196, 49, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/photo-of-sea-turtle.jpg",
    author: "Jeremy Bishop",
    url: "https://www.pexels.com/photo/photo-of-sea-turtle-2765872/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(56, 159, 216, 1)),
        position: 0.06,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(173, 239, 216, 1)),
        position: 0.41,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(47, 198, 250, 1)),
        position: 0.5,
      ),
    ],
  ),
  SourceImage(
    imagePath:
        "assets/images/red-and-black-temple-surrounded-by-trees-photo.jpg",
    author: "Belle Co",
    url:
        "https://www.pexels.com/photo/red-and-black-temple-surrounded-by-trees-photo-402028/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(64, 182, 247, 1)),
        position: 0.06,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(173, 239, 255, 1)),
        position: 0.21,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 45, 45, 1)),
        position: 0.48,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(22, 248, 255, 1)),
        position: 0.71,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(248, 66, 66, 1)),
        position: 1,
      ),
    ],
  ),
];
