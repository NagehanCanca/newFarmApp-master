import 'dart:io';
import 'package:farmsoftnew/homepage/model/animal/animals_list.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../model/animal_model.dart';
import '../../../model/building_model.dart';
import '../../../model/paddock_model.dart';
import '../../../model/section_model.dart';
import '../../../service/base.service.dart';
import 'animal_card_test.dart';

class AnimalSearchWidget extends StatefulWidget {
  final String operationType; // operationType ekleniyor

  AnimalSearchWidget({required this.operationType});
  @override
  _AnimalSearchWidgetState createState() => _AnimalSearchWidgetState();
}

class _AnimalSearchWidgetState extends State<AnimalSearchWidget> {
  TextEditingController searchController = TextEditingController();
  AnimalModel? selectedAnimal;
  List<BuildingModel> buildings = [];
  List<SectionModel> sections = [];
  List<PaddockModel> paddocks = [];
  BuildingModel? selectedBuilding;
  SectionModel? selectedSection;
  PaddockModel? selectedPaddock;
  String animalRfid = "";

  @override
  void initState() {
    super.initState();
    _fetchBuildings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hayvan ve Alan Arama - ${widget.operationType}'), // operationType başlıkta gösteriliyor
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'RFID Giriniz',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchAnimal,
              child: const Text('Hayvan Ara'),
            ),
            const SizedBox(height: 16),
            if (selectedAnimal != null)
            // ListTile(
            //   title: Text(selectedAnimal!.animalTypeDescription ?? ''),
            //   subtitle: Text(selectedAnimal!.buildDescription ?? ''),
            // ),
              const SizedBox(height: 32),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimalsListPage(paddockId: selectedPaddock!.id!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen bir padok seçin'),
                    ),
                  );
                }
              },
              child: const Text('Hayvanları Listele '),
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

  Future<void> _searchAnimal() async {
    try {
      Response response = await dio.get(
        "Animal/GetAnimalByRfId",
        queryParameters: {
          "RfId": searchController.text,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.data != null) {
          AnimalModel animal = AnimalModel.fromJson(response.data);
          setState(() {
            selectedAnimal = animal;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimalCard(
                animal: animal ),
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
}
