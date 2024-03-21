import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/treatment_model.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/transfer_model.dart';
import '../../../service/base.service.dart';

class AnimalDetailsPage extends StatefulWidget {
  final AnimalModel animal;

  const AnimalDetailsPage({Key? key, required this.animal}) : super(key: key);

  @override
  _AnimalDetailsPageState createState() => _AnimalDetailsPageState();
}

class _AnimalDetailsPageState extends State<AnimalDetailsPage> {
  late List<TransferModel> transferInfo;
  late List<TreatmentModel> treatmentInfo;
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    transferInfo = []; // transferInfo'yu başlatıyoruz
    treatmentInfo = [];
    _fetchTransferInfo(widget.animal.id!);
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final int updateUserId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hayvan Detayları'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Container(
            alignment: Alignment.center,
            child: Text('Maliyet Bilgileri'),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text('Yem Bilgileri'),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text('Tartım Bilgileri'),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text('Tedavi Bilgileri'),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Transfer Bilgileri',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (transferInfo.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Eski')),
                          DataColumn(label: Text('Yeni')),
                          DataColumn(label: Text('İşlem Yapan')),
                          DataColumn(label: Text('İşlem Tarihi')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(transferInfo[0].oldPaddockString())),
                            DataCell(Text(transferInfo[0].newPaddockString())),
                            DataCell(Text(transferInfo[0].insertUser ?? '')),
                            DataCell(Text(transferInfo[0].date?.toString() ?? '')),
                          ]),
                        ],
                      ),
                    ),
                  if (transferInfo.isEmpty)
                    const Text('Transfer bilgileri bulunamadı.'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              _selectedIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Maliyet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            label: 'Yem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Tartım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: 'Tedavi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transfer',
          ),
        ],
      ),
    );
  }

  Future<void> _fetchTransferInfo(int animalId) async {
    try {
      Response response = await dio.get(
          "Transfer/GetAllAnimalTransfersByAnimalId",
          queryParameters: {
            "animalId": animalId,
          }
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;

        transferInfo =  responseData.map((json) => TransferModel.fromJson(json)).toList();
        setState(() {

        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transfer bilgileri getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
