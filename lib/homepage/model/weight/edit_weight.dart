import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/service/base.service.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/building_model.dart';
import '../../../model/section_model.dart';
import '../../../model/paddock_model.dart';

class NewWeightPage extends StatefulWidget {
  final String operationType;

  NewWeightPage(this.operationType);

  @override
  _NewWeightPageState createState() => _NewWeightPageState();
}

class _NewWeightPageState extends State<NewWeightPage> {
  List<BuildingModel> buildings = [];
  List<SectionModel> sections = [];
  List<PaddockModel> paddocks = [];
  BuildingModel? selectedBuilding;
  SectionModel? selectedSection;
  PaddockModel? selectedPaddock;
  AnimalModel? selectedAnimal;

  @override
  void initState() {
    super.initState();
    buildings = [];
    sections = [];
    paddocks = [];
    selectedAnimal = AnimalModel();
    selectedBuilding = null;
    selectedSection = null;
    selectedPaddock = null;
    _fetchBuildings();
  }

  Future<void> _fetchBuildings() async {
    try {
      Response response = await dio.get("Building");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          buildings =
              responseData.map((json) => BuildingModel.fromJson(json)).toList();
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
          sections =
              responseData.map((json) => SectionModel.fromJson(json)).toList();
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
          paddocks =
              responseData.map((json) => PaddockModel.fromJson(json)).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genel Tartım Bilgileri',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Durum'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Tarih'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Tartım Cihazı'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Yeni Hayvan Seçimi'),
                  // Yeni hayvan seçimi radiobutton veya checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          // Checkbox durumunu güncelleme
                        },
                      ),
                      Text('Yeni hayvan ekle'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Bina Seçimi'),
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
                  Text('Bölüm Seçimi'),
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
                  Text('Padok Seçimi'),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}