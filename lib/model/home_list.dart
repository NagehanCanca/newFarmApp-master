import 'package:farmsoftnew/homepage/model/animal/animal_test.dart';
import 'package:flutter/material.dart';

import '../homepage/home_design.dart';
import '../introduction/introduction_animation_screen.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/images/androidLoya.png',
      navigateScreen: const IntroductionAnimationScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/Logo.png',
      navigateScreen: HomeDesignScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/welcome.png',
      navigateScreen: AnimalTestScreen(),
    ),
  ];
}
