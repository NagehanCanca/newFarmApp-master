import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/base_cache_manager.dart';
import '../../../model/building_model.dart';
import '../../../model/paddock_model.dart';
import '../../../model/section_model.dart';
import '../../../service/base.service.dart';

class NextSelectionScreen extends StatefulWidget {
  final AnimalModel selectedAnimal;
  final String operationType;

  NextSelectionScreen({required this.selectedAnimal, required this.operationType});

  @override
  _NextSelectionScreenState createState() => _NextSelectionScreenState();
}

class _NextSelectionScreenState extends State<NextSelectionScreen> {
  BuildingModel? selectedBuilding;
  SectionModel? selectedSection;
  PaddockModel? selectedPaddock;

  List<BuildingModel> buildings = [];
  List<SectionModel> sections = [];
  List<PaddockModel> paddocks = [];

  @override
  void initState() {
    super.initState();
    _fetchBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bina, Bölüm ve Padok Seçimi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<BuildingModel>(
              value: selectedBuilding,
              hint: const Text('Bina Seçiniz'),
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
            const SizedBox(height: 16),
            DropdownButtonFormField<SectionModel>(
              value: selectedSection,
              hint: const Text('Bölüm Seçiniz'),
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
            const SizedBox(height: 16),
            DropdownButtonFormField<PaddockModel>(
              value: selectedPaddock,
              hint: const Text('Padok Seçiniz'),
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Check if all selections are made
                if (selectedBuilding == null || selectedSection == null || selectedPaddock == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen bina, bölüm ve padok seçimlerini tamamlayın.'),
                    ),
                  );
                  return;
                }

                // Perform transfer operation
                _transferAnimalToPaddock(selectedPaddock!.id!);
              },
              child: Text('İleri'),
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
        data: widget.selectedAnimal.toJson(),
      );
      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hayvan başarıyla transfer edildi'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context); // Geri dönüş yap
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
