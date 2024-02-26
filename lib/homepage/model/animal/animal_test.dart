// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../../../model/animal_model.dart';
// import '../../../model/base_cache_manager.dart';
// import '../../../service/base.service.dart';
//
// import 'animal_card_test.dart';
//
//
// class AnimalTestScreen extends StatefulWidget {
//   @override
//   _AnimalTestScreenState createState() => _AnimalTestScreenState();
// }
//
// class _AnimalTestScreenState extends State<AnimalTestScreen> {
//   final TextEditingController searchController = TextEditingController();
//   String animalRfid = "";
//
//   // Future<void> fetchAnimalRfid() async {
//   //   try {
//   //     Response response = await dio.get(
//   //       "Animal",
//   //       queryParameters: {
//   //         "rfid": searchController.text,
//   //       },
//   //     );
//   //     if (response.statusCode == HttpStatus.ok) {
//   //       AnimalModel animal = AnimalModel.fromJson(response.data['data']);
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => AnimalCard(animal: animal)),
//   //       );
//   //     } else {
//   //       //Handle error
//   //       setState(() {
//   //         animalRfid = "Bulunmuyor";
//   //       });
//   //     }
//   //   } catch (e) {
//   //     //Handle error
//   //     setState(() {
//   //       animalRfid = "Bulunamadı";
//   //     });
//   //   }
//   // }
//
//   Future<void> fetchAnimalRfid() async {
//     try {
//       Response response = await dio.get(
//         "Animal",
//         queryParameters: {
//           "rfid": searchController.text,
//         },
//       );
//       if (response.statusCode == HttpStatus.ok) {
//         if (response.data != null) {
//           AnimalModel animal = AnimalModel.fromJson(response.data);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AnimalCard(animal: animal),
//             ),
//           );
//         } else {
//           setState(() {
//             animalRfid = "Bulunmuyor";
//           });
//         }
//       }
//     } catch (e, stackTrace) {
//       print('Hata: $e, $stackTrace');
//       setState(() {
//         animalRfid = "Bir hata oluştu";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Animal Test'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: searchController,
//               decoration: const InputDecoration(
//                 labelText: 'Search',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: fetchAnimalRfid,
//               child: const Text('Fetch RFID'),
//             ),
//             const SizedBox(height: 20),
//             Text('RFID: $animalRfid'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../model/animal_model.dart';
import '../../../model/base_cache_manager.dart';
import '../../../service/base.service.dart';

import 'animal_card_test.dart';


class AnimalTestScreen extends StatefulWidget {
  @override
  _AnimalTestScreenState createState() => _AnimalTestScreenState();
}

class _AnimalTestScreenState extends State<AnimalTestScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  String animalRfid = "";

  Future<void> fetchAnimalRfid() async {
    try {
      String searchText = searchController.text;
      String rfid;
      String type;

      // RFID ve hayvan türünü ayır
      List<String> searchParts = searchText.split(" ");
      if (searchParts.length == 2) {
        rfid = searchParts[0];
        type = searchParts[1];
      } else if (searchParts.length == 1) {
        // Eğer sadece bir giriş varsa, bu sadece RFID olabilir
        rfid = searchText;
      } else {
        // Hatalı giriş durumu
        setState(() {
          animalRfid = "Geçersiz giriş";
          return;
        });
      }

      Response response = await dio.get(
        "Animal",
        queryParameters: {
          "rfid": searchController.text,
          "type":  typeController.text,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.data != null) {
          AnimalModel animal = AnimalModel.fromJson(response.data);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimalCard(animal: animal),
            ),
          );
        } else {
          setState(() {
            animalRfid = "Bulunmuyor";
          });
        }
      }
    } catch (e, stackTrace) {
      print('Hata: $e, $stackTrace');
      setState(() {
        animalRfid = "Bir hata oluştu";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Rfid, Hayvan türü...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchAnimalRfid,
              child: const Text('Arama yap'),
            ),
            const SizedBox(height: 20),
            Text('RFID: $animalRfid'),
          ],
        ),
      ),
    );
  }
}
