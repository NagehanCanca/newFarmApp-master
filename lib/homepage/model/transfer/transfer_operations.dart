// import 'package:farmsoftnew/homepage/model/transfer/transfer_animal_search.dart';
// import 'package:flutter/material.dart';
// import 'package:farmsoftnew/homepage/model/transfer/new_selection.dart';
//
// class TransferOperationsPage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Transfer İşlemleri'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // Yeni transfer için TransferAnimalSearchWidget sayfasını açma
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TransferAnimalSearchWidget()), // AnimalSearchWidget yerine TransferAnimalSearchWidget kullanıldı
//                 ).then((selectedAnimal) {
//                   // Once an animal is selected, navigate to the next selection screen
//                   if(selectedAnimal != null) {
//                     // Navigate to the next selection screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => NextSelectionScreen(selectedAnimal: selectedAnimal, operationType: 'Yeni Transfer',)), // operationType düzeltilmeli
//                     );
//                   }
//                 });
//               },
//               child: const Text('Yeni Transfer'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Toplu transfer için TransferAnimalSearchWidget sayfasını açma
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TransferAnimalSearchWidget()), // AnimalSearchWidget yerine TransferAnimalSearchWidget kullanıldı
//                 ).then((selectedAnimal) {
//                   // Once an animal is selected, navigate to the next selection screen
//                   if(selectedAnimal != null) {
//                     // Navigate to the next selection screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => NextSelectionScreen(selectedAnimal: selectedAnimal, operationType: 'Toplu Transfer',)), // operationType düzeltilmeli
//                     );
//                   }
//                 });
//               },
//               child: const Text('Toplu Transfer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/transfer/transfer_animal_search.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/transfer_model.dart';
import '../../../service/base.service.dart';

class TransferOperationsPage extends StatefulWidget {
  final List<AnimalModel> selectedAnimals;

  const TransferOperationsPage({Key? key, required this.selectedAnimals}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferOperationsPage> {
  late List<TransferModel> _transfers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransfers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Bilgileri'),
      ),
      body: _isLoading
          ? _buildLoadingIndicator()
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildTransferTable(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransferOptions(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTransferTable() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Sıra No',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Tarih',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Eski Bina Adı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Eski Bölüm Adı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Eski Padok Adı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Yeni Bina Adı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Yeni Bölüm Adı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Yeni Padok Adı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Kaydeden Kullanıcı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Kayıt Tarihi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: _transfers
          .map(
            (transfer) => DataRow(
          cells: <DataCell>[
            DataCell(Text(transfer.id.toString() ?? '')),
            DataCell(Text(_formatDate(transfer.insertDate))),
            DataCell(Text(transfer.oldBuilding?.toString() ?? '')),
            DataCell(Text(transfer.oldSection?.toString() ?? '')),
            DataCell(Text(transfer.oldPaddock?.toString() ?? '')),
            DataCell(Text(transfer.newBuilding?.toString() ?? '')),
            DataCell(Text(transfer.newSection?.toString() ?? '')),
            DataCell(Text(transfer.newPaddock?.toString() ?? '')),
            DataCell(Text(transfer.insertUser.toString() ?? '')),
            DataCell(Text(_formatDate(transfer.updateDate ?? DateTime.now()))),
          ],
        ),
      )
          .toList(),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  Future<void> _fetchTransfers() async {
    try {
      Response response = await dio.get("Transfer/GetAllTransfers");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          _transfers = responseData.map((json) => TransferModel.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching transfers: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transferler alınamadı'),
        ),
      );
    }
  }

  void _showTransferOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Yeni Transfer'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToTransferAnimalSearch('Yeni Transfer');
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Toplu Transfer'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToTransferAnimalSearch('Toplu Transfer');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToTransferAnimalSearch(String operationType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferAnimalSearchWidget(),
      ),
    );
  }
}
