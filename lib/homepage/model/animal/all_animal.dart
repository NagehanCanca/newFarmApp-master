// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../../../model/animal_model.dart';
// import '../../../model/paddock_model.dart';
// import '../../../service/base.service.dart';
//
// class AllAnimalsPage extends StatefulWidget {
//   final AnimalModel animal;
//
//   const AllAnimalsPage({super.key, required this.animal});
//   @override
//   _AllAnimalsPageState createState() => _AllAnimalsPageState();
// }
//
// class _AllAnimalsPageState extends State<AllAnimalsPage> {
//   late List<PaddockModel> _paddocks = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPaddocksAndAnimals();
//   }
//
//   Future<void> _fetchPaddocksAndAnimals() async {
//     try {
//       Response response = await dio.get(
//           "Paddock/GetAllPaddocksAndAnimals"
//       );
//
//       if (response.statusCode == HttpStatus.ok) {
//         setState(() {
//           // Response'dan gelen verileri işle
//           _paddocks = (response.data as List)
//               .map((item) => PaddockModel.fromJson(item))
//               .toList();
//         });
//       } else {
//         throw Exception('HTTP Hatası ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Hata: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Verileri alırken bir hata oluştu'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tüm Hayvanlar'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _fetchPaddocksAndAnimals,
//           ),
//         ],
//       ),
//       body: _paddocks.isNotEmpty
//           ? ListView.builder(
//         itemCount: _paddocks.length,
//         itemBuilder: (context, index) {
//           return _buildPaddockExpansionTile(_paddocks[index]);
//         },
//       )
//           : Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
//
//   Widget _buildPaddockExpansionTile(PaddockModel paddock) {
//     return ExpansionTile(
//       title: Text(paddock.paddockType.toString()),
//       children: paddock.animal.map((animal) {
//         return ListTile(
//           title: Text(animal.name),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Cins: ${widget.animal.animalTypeDescription}'),
//               Text('Küpe No: ${widget.animal.earringNumber}'),
//               Text('RFID: ${widget.animal.rfid}'),
//               // RFID'yi göster
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
