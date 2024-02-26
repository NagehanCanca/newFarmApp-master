// import 'package:flutter/material.dart';
//
// class VaccinePage extends StatefulWidget {
//   @override
//   _VaccinePageState createState() => _VaccinePageState();
// }
//
// class _VaccinePageState extends State<VaccinePage> {
//   DateTime? entryDate;
//   DateTime? exitDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Aşı Sayfası'),
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Giriş Tarihi Seçin:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             InkWell(
//               onTap: () {
//                 _selectDate(context, true);
//               },
//               child: Container(
//                 padding: EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       entryDate == null
//                           ? 'Giriş Tarihi Seçin'
//                           : '${entryDate!.day}/${entryDate!.month}/${entryDate!.year}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     Icon(Icons.calendar_today),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             const Text(
//               'Çıkış Tarihi Seçin:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             InkWell(
//               onTap: () {
//                 _selectDate(context, false);
//               },
//               child: Container(
//                 padding: EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       exitDate == null
//                           ? 'Çıkış Tarihi Seçin'
//                           : '${exitDate!.day}/${exitDate!.month}/${exitDate!.year}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     const Icon(Icons.calendar_today),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _listVaccines(entryDate, exitDate);
//               },
//               child: Text('Aşıları Listele'),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.green, // Butonun arka plan rengi
//                 onPrimary: Colors.white, // Buton metin rengi
//                 shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Future<void> _selectDate(BuildContext context, bool isEntryDate) async {
//     final DateTime? pickedDate = await showCustomDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         if (isEntryDate) {
//           entryDate = pickedDate;
//         } else {
//           exitDate = pickedDate;
//         }
//       });
//     }
//   }
//
//   Future<void> _listVaccines(DateTime? entryDate, DateTime? exitDate) async {
//     // Burada seçilen tarihlerle yaklaşan aşıları listelemek için bir işlev çağrılabilir.
//     // entryDate ve exitDate değişkenlerinde seçilen tarihler mevcut olacak.
//     // Örneğin:
//     // final List<Vaccine> upcomingVaccines = await fetchUpcomingVaccines(entryDate, exitDate);
//     // Sonra, listelenen aşılarla ilgili bir widget oluşturabilir veya başka bir işlem yapılabilir.
//   }
//
//   Future<DateTime?> showCustomDatePicker({
//     required BuildContext context,
//     required DateTime? initialDate,
//     required DateTime firstDate,
//     required DateTime lastDate,
//   }) async {
//     return await showModalBottomSheet<DateTime>(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: 300,
//           child: Column(
//             children: [
//               Expanded(
//                 child: CalendarDatePicker(
//                   initialDate: initialDate ?? DateTime.now(),
//                   firstDate: firstDate,
//                   lastDate: lastDate,
//                   onDateChanged: (DateTime newDate) {
//                     Navigator.pop(context, newDate);
//                   },
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Tamam'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: VaccinePage(),
//   ));
// }

import 'package:flutter/material.dart';

import '../../design_homepage_theme.dart';

class VaccinePage extends StatefulWidget {
  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  DateTime? entryDate;
  DateTime? exitDate;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignHomePageAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset('assets/images/aşı.png'),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignHomePageAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignHomePageAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text(
                              'Aşı Takvimi',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignHomePageAppTheme.darkerText,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              _selectDate(context, true);
                            },
                            child: Text(entryDate == null
                                ? 'Giriş Tarihi Seç'
                                : '${entryDate!.day}/${entryDate!.month}/${entryDate!.year}'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // Butonun arka plan rengi
                              onPrimary: Colors.white, // Buton metin rengi
                              shape: RoundedRectangleBorder(
                                // Butonun şekli ve kavisleri
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              _selectDate(context, false);
                            },
                            child: Text(exitDate == null
                                ? 'Çıkış Tarihi Seç'
                                : '${exitDate!.day}/${exitDate!.month}/${exitDate!.year}'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // Butonun arka plan rengi
                              onPrimary: Colors.white, // Buton metin rengi
                              shape: RoundedRectangleBorder(
                                // Butonun şekli ve kavisleri
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (entryDate != null && exitDate != null) {
                                _listVaccines(entryDate, exitDate);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Lütfen giriş ve çıkış tarihlerini seçin.'),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Text('Aşıları Listele'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // Butonun arka plan rengi
                              onPrimary: Colors.white, // Buton metin rengi
                              shape: RoundedRectangleBorder(
                                // Butonun şekli ve kavisleri
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController!, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: DesignHomePageAppTheme.nearlyBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: const Center(
                      child: Icon(
                        Icons.vaccines,
                        color: DesignHomePageAppTheme.nearlyWhite,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    // child: const Icon(
                    //   Icons.arrow_back_ios,
                    //   color: DesignHomePageAppTheme.nearlyBlack,
                    // ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isEntryDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isEntryDate) {
          entryDate = pickedDate;
        } else {
          exitDate = pickedDate;
        }
      });
    }
  }

  Future<void> _listVaccines(DateTime? entryDate, DateTime? exitDate) async {
    // Burada seçilen tarih aralığına göre aşıları listeleme işlemi gerçekleştirilir.
    // Örneğin:
    // final List<Vaccine> selectedVaccines = await fetchVaccinesBetween(entryDate, exitDate);
    // Sonra, listelenen aşılarla ilgili bir widget oluşturabilir veya başka bir işlem yapılabilir.
  }
}
