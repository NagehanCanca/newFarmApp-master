import 'package:farmsoftnew/screens/bait_mixed_screen.dart';
import 'package:farmsoftnew/screens/paddock_screen.dart';
import 'package:farmsoftnew/screens/statistics_screen.dart';
import 'package:farmsoftnew/screens/tracking_screen.dart';
import 'package:farmsoftnew/screens/weighing_screen.dart';
import 'package:flutter/material.dart';
import '../../customdrawer/drawer_user_controller.dart';
import '../../customdrawer/home_drawer_card.dart';
import '../../homepage/model/vaccine/vaccine_page.dart';
import '../../theme/app_theme.dart';
import '../treatment_screen.dart';
import '../home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.Statistics:
          setState(() {
            screenView = StatisticsScreen();
          });
          break;
        case DrawerIndex.Paddock:
          setState(() {
            screenView = PaddockScreen();
          });
        case DrawerIndex.Tracking:
          setState(() {
            screenView = AnimalTrackingScreen();
          });
          break;
        case DrawerIndex.HOME:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Weighing:
          setState(() {
            screenView = WeighingScreen();
          });
          break;
        case DrawerIndex.Treatment:
          setState(() {
            screenView = TreatmentInfoScreen();
          });
          break;
        case DrawerIndex.BaitMixed:
          setState(() {
            screenView = BaitMixedScreen();
          });
          break;
        case DrawerIndex.Vaccine:
          setState(() {
            screenView = VaccinePage();
          });
          break;
        default:
          break;
      }
    }
  }
}
