class HomePage {
  HomePage({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    //this.money = 0,
    //this.rating = 0.0,
  });

  String title;
  int lessonCount;
  //int money;
  //double rating;
  String imagePath;

  static List<HomePage> categoryList = <HomePage>[
    HomePage(
      imagePath: 'assets/images/Logo.png',
      title: 'Tüm Hayvanlar',
      lessonCount: 24,
      //money: 25,
      //rating: 4.3,
    ),
    HomePage(
      imagePath: 'assets/images/takip.jpg',
      title: 'Padoklar',
      lessonCount: 22,
      //money: 18,
      //rating: 4.6,
    ),
    // HomePage(
    //   imagePath: 'assets/images/mö.png',
    //   title: 'User interface Design',
    //   lessonCount: 24,
    //   //money: 25,
    //   //rating: 4.3,
    // ),
    // HomePage(
    //   imagePath: 'assets/images/mö.png',
    //   title: 'User interface Design',
    //   lessonCount: 22,
    //   //money: 18,
    //   //rating: 4.6,
    // ),
  ];

  static List<HomePage> popularCourseList = <HomePage>[
    HomePage(
      imagePath: 'assets/images/aşı.png',
      title: 'Aşı',
      lessonCount: 12,
      //money: 25,
      //rating: 4.8,
    ),
    HomePage(
      imagePath: 'assets/images/tedavi.png',
      title: 'Tedavi',
      lessonCount: 28,
      //money: 208,
      //rating: 4.9,
    ),
    HomePage(
      imagePath: 'assets/images/transfer.png',
      title: 'Transfer İşlemleri',
      lessonCount: 12,
      //money: 25,
      //rating: 4.8,
    ),
    HomePage(
      imagePath: 'assets/images/mö.jpg',
      title: 'Hayvan ',
      lessonCount: 28,
      //money: 208,
     // rating: 4.9,
    ),
  ];
}
