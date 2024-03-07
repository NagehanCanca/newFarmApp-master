import 'dart:io';
import 'package:dio/dio.dart';
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

class _AnimalDetailsPageState extends State<AnimalDetailsPage> with SingleTickerProviderStateMixin {
  late List<TransferModel> transferInfo;

  @override
  void initState() {
    super.initState();
    transferInfo = []; // transferInfo'yu başlatıyoruz
    _tabController = TabController(length: 5, vsync: this);
    _fetchTransferInfo(widget.animal.id!);
  }

  @override
  void dispose() {
    _tabController.dispose(); // _tabController'ı temizliyoruz
    super.dispose();
  }

  late TabController _tabController;
  final int updateUserId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hayvan Detayları'),
      ),
      body: RotatedBox( // Yatay konum için RotatedBox kullanın
        quarterTurns: 1, // İçeriği 90 derece döndürün
        child: Column( // Yatay konumda bir sütun kullanın
          children: [
            DefaultTabController(
              length: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Maliyet'),
                      Tab(text: 'Yem'),
                      Tab(text: 'Tartım'),
                      Tab(text: 'Tedavi'),
                      Tab(text: 'Transfer'),
                    ],
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black87,
                    indicator: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    isScrollable: false,
                    labelStyle: const TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Text('Maliyet Bilgileri'),
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
                                const Text(
                                  'Transfer Bilgileri:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                if (transferInfo.isNotEmpty)
                                  DataTable(
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
                                if (transferInfo.isEmpty)
                                  const Text('Transfer bilgileri bulunamadı.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
