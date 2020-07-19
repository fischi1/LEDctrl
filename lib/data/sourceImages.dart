import 'package:fischi/domain/ColorBreakpoint.dart';
import 'package:fischi/domain/SourceImage.dart';
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
  SourceImage(
    imagePath: "assets/images/bloom-blooming-blossom-blur.jpg",
    author: "Pixabay",
    url: "https://www.pexels.com/photo/bloom-blooming-blossom-blur-355663/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(93, 255, 0, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(164, 35, 240, 1)),
        position: 0.15,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(146, 2, 244, 1)),
        position: 0.61,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/low-angle-photo-of-red-and-orange-umbrella.jpg",
    author: "Peter Fazekas",
    url:
        "https://www.pexels.com/photo/low-angle-photo-of-red-and-orange-umbrella-1170594/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 10, 0, 1)),
        position: 0.25,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 76, 0, 1)),
        position: 0.26,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 76, 0, 1)),
        position: 0.45,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 10, 0, 1)),
        position: 0.46,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 10, 0, 1)),
        position: 0.7,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(70, 160, 180, 1)),
        position: 0.71,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/pink-and-white-flowers-in-tilt-shift-lens.jpg",
    author: "Brett Sayles",
    url:
        "https://www.pexels.com/photo/pink-and-white-flowers-in-tilt-shift-lens-4212936/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(98, 59, 159, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(248, 113, 113, 1)),
        position: 0.19,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(98, 59, 159, 1)),
        position: 0.48,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(248, 113, 113, 1)),
        position: 0.71,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(98, 59, 159, 1)),
        position: 0.83,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(248, 113, 113, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/silhouette-of-mountains.jpg",
    author: "Simon Matzinger",
    url: "https://www.pexels.com/photo/silhouette-of-mountains-1323550/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(80, 201, 255, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(224, 174, 48, 1)),
        position: 0.33,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(242, 103, 48, 1)),
        position: 0.66,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(210, 79, 144, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/close-up-photo-of-pizza-near-bonfire.jpg",
    author: "Vinicius Benedit",
    url:
        "https://www.pexels.com/photo/close-up-photo-of-pizza-near-bonfire-1082343/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 65, 0, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 0, 0, 1)),
        position: 0.14,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 65, 0, 1)),
        position: 0.29,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 0, 0, 1)),
        position: 0.43,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 65, 0, 1)),
        position: 0.57,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 0, 0, 1)),
        position: 0.71,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 65, 0, 1)),
        position: 0.86,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 0, 0, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/waterfall-near-trees.jpg",
    author: "Roni Alfasi",
    url: "https://www.pexels.com/photo/waterfall-near-trees-2737248/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(16, 15, 15, 1)),
        position: 0,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(172, 163, 89, 1)),
        position: 0.18,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(170, 194, 64, 1)),
        position: 0.41,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(117, 140, 42, 1)),
        position: 0.69,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(16, 15, 15, 1)),
        position: 1,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/seaport-during-daytime.jpg",
    author: "Pok Rie",
    url: "https://www.pexels.com/photo/seaport-during-daytime-132037/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(75, 146, 189, 1)),
        position: 0.07,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 86, 0, 1)),
        position: 0.14,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 86, 0, 1)),
        position: 0.87,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(75, 146, 189, 1)),
        position: 0.93,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/close-up-of-fruits-in-bowl.jpg",
    author: "Pixabay",
    url: "https://www.pexels.com/photo/close-up-of-fruits-in-bowl-327098/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(226, 84, 0, 1)),
        position: 0.12,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(71, 143, 0, 1)),
        position: 0.2,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(226, 84, 0, 1)),
        position: 0.28,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(226, 84, 0, 1)),
        position: 0.64,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(71, 143, 0, 1)),
        position: 0.72,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(226, 84, 0, 1)),
        position: 0.8,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/seashore-scenery.jpg",
    author: "Greg",
    url: "https://www.pexels.com/photo/seashore-scenery-2418664/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(140, 44, 255, 1)),
        position: 0.12,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 211, 242, 1)),
        position: 0.17,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(140, 44, 255, 1)),
        position: 0.22,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(140, 44, 255, 1)),
        position: 0.27,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 211, 242, 1)),
        position: 0.32,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(140, 44, 255, 1)),
        position: 0.37,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(140, 44, 255, 1)),
        position: 0.42,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 211, 242, 1)),
        position: 0.47,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(140, 44, 255, 1)),
        position: 0.52,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/crystal-glass-on-a-colorful-background.jpg",
    author: "Steve Johnson",
    url:
        "https://www.pexels.com/photo/crystal-glass-on-a-colorful-background-2179374/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 0, 44, 1)),
        position: 0.16,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(35, 255, 0, 1)),
        position: 0.56,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(1, 45, 92, 1)),
        position: 0.9,
      ),
    ],
  ),
  SourceImage(
    imagePath: "assets/images/multicolored-abstract-painting.jpg",
    author: "Steve Johnson",
    url: "https://www.pexels.com/photo/multicolored-abstract-painting-1548111/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 0, 186, 1)),
        position: 0.06,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(254, 67, 1, 1)),
        position: 0.14,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(219, 160, 2, 1)),
        position: 0.27,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(219, 160, 2, 1)),
        position: 0.47,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(248, 3, 255, 1)),
        position: 0.51,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(248, 3, 255, 1)),
        position: 0.69,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(0, 177, 255, 1)),
        position: 0.8,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(0, 177, 255, 1)),
        position: 0.82,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 34, 0, 1)),
        position: 0.87,
      ),
    ],
  ),
  SourceImage(
    imagePath:
        "assets/images/green-trees-under-blue-and-orange-sky-during-sunset.jpg",
    author: "Lisa Fotios",
    url:
        "https://www.pexels.com/photo/green-trees-under-blue-and-orange-sky-during-sunset-1107717/",
    breakpoints: [
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 114, 0, 1)),
        position: 0.07,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(167, 201, 224, 1)),
        position: 0.17,
      ),
      ColorBreakpoint(
        color: HSVColor.fromColor(Color.fromRGBO(255, 114, 0, 1)),
        position: 0.27,
      ),
    ],
  ),
];
