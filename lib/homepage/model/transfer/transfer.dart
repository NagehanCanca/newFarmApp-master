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
  final AnimalModel selectedAnimal;

  TransferPage({required this.selectedAnimal});

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
  late TransferModel? _transferInfo;

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
        title: const Text('Transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: const Text('Transfer Et'),
                  ),
                ],
              ),
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
        Navigator.pop(context, selectedAnimal);
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
