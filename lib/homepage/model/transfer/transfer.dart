import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/animal_model.dart';
import 'package:flutter/material.dart';

import '../../../model/base_cache_manager.dart';
import '../../../model/building_model.dart';
import '../../../model/section_model.dart';
import '../../../model/paddock_model.dart';
import '../../../model/transfer_model.dart';
import '../../../service/base.service.dart';

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  late List<BuildingModel> buildings;
  late List<SectionModel> sections;
  late List<PaddockModel> paddocks;
  late AnimalModel selectedAnimal;
  late BuildingModel? selectedBuilding;
  late SectionModel? selectedSection;
  late PaddockModel? selectedPaddock;

  @override
  void initState() {
    super.initState();
    buildings = [];
    sections = [];
    paddocks = [];
    selectedAnimal = AnimalModel(); // Boş bir hayvan nesnesi oluşturuluyor
    selectedBuilding = null;
    selectedSection = null;
    selectedPaddock = null;
    _fetchBuildings(); // Binaları getiren metodu çağırılıyor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<BuildingModel>(
              value: selectedBuilding,
              hint: Text('Bina Seçiniz'),
              items: buildings
                  .map((building) => DropdownMenuItem(
                value: building,
                child: Text(building.description ?? ''),
              ))
                  .toList(),
              onChanged: (building) {
                setState(() {
                  selectedBuilding = building;
                  selectedSection = null;
                  selectedPaddock = null;
                  sections.clear();
                  paddocks.clear();
                  if (building != null) {
                    _fetchSections(building.id!);
                  }
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<SectionModel>(
              value: selectedSection,
              hint: Text('Bölüm Seçiniz'),
              items: sections
                  .map((section) => DropdownMenuItem(
                value: section,
                child: Text(section.description ?? ''),
              ))
                  .toList(),
              onChanged: (section) {
                setState(() {
                  selectedSection = section;
                  selectedPaddock = null;
                  paddocks.clear();
                  if (section != null) {
                    _fetchPaddocks(section.id!);
                  }
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<PaddockModel>(
              value: selectedPaddock,
              hint: Text('Paddock Seçiniz'),
              items: paddocks
                  .map((paddock) => DropdownMenuItem(
                value: paddock,
                child: Text(paddock.description ?? ''),
              ))
                  .toList(),
              onChanged: (paddock) {
                setState(() {
                  selectedPaddock = paddock;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedPaddock != null) {
                  _transferAnimalToPaddock(selectedPaddock!.id!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen bir paddock seçiniz.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Transfer Et'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchBuildings() async {
    try {
      Response response = await dio.get("Building");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          buildings = responseData.map((json) => BuildingModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Binalar getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _fetchSections(int buildingId) async {
    try {
      Response response = await dio.get("Section?buildingId=$buildingId");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          sections = responseData.map((json) => SectionModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bölümler getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _fetchPaddocks(int sectionId) async {
    try {
      Response response = await dio.get("Paddock?sectionId=$sectionId");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          paddocks = responseData.map((json) => PaddockModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Paddock\'lar getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _transferAnimalToPaddock(int paddockId) async {
    try {
      Response response = await dio.put(
        "Animal/UpdateAnimalPaddockTransfer",
        queryParameters: {
          "updateUserId": cachemanager.getItem(0)?.id,
          "newPaddockId": paddockId,
        },
        data: selectedAnimal.toJson(),
      );
      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hayvan başarıyla transfer edildi'),
            duration: Duration(seconds: 2),
          ),
        );
        TransferModel transferInfo = TransferModel(
          id: 0, // Bu kısmı veritabanından almanız gereken değerlerle doldurun
          animalId: selectedAnimal.id!, // Seçili hayvanın ID'si
          oldPaddockId: selectedAnimal.paddockId, // Seçili hayvanın mevcut paddock ID'si
          oldPaddock: selectedPaddock?.description ?? '', // Seçili hayvanın mevcut paddock'ının açıklaması
          oldSectionId: selectedSection?.id, // Seçili hayvanın mevcut bölüm ID'si
          oldSection: selectedSection?.description ?? '', // Seçili hayvanın mevcut bölümünün açıklaması
          oldBuildingId: selectedBuilding?.id, // Seçili hayvanın mevcut bina ID'si
          oldBuilding: selectedBuilding?.description ?? '', // Seçili hayvanın mevcut bina açıklaması
          newPaddockId: selectedPaddock!.id!, // Yeni paddock ID'si
          newPaddock: selectedPaddock?.description ?? '', // Yeni paddock'ın açıklaması
          newSectionId: selectedSection?.id, // Yeni bölüm ID'si
          newSection: selectedSection?.description, // Yeni bölümün açıklaması
          newBuildingId: selectedBuilding?.id, // Yeni bina ID'si
          newBuilding: selectedBuilding?.description, // Yeni bina açıklaması
          date: DateTime.now(), // Transfer tarihi
          insertUser: 'Insert User', // Ekleme yapan kullanıcı
          insertDate: DateTime.now(), // Ekleme tarihi
          updateUser: 'Update User', // Güncelleyen kullanıcı
          updateDate: DateTime.now(), // Güncelleme tarihi
        );
        Navigator.pop(context);
        Navigator.pop(context, transferInfo);
        // Navigator.pop(context);
      } else {
        throw Exception('Transfer işlemi başarısız oldu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hayvan transfer edilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
