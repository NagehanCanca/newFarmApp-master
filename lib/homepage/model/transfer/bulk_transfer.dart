import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/base_cache_manager.dart';
import '../../../model/building_model.dart';
import '../../../model/paddock_model.dart';
import '../../../model/section_model.dart';
import '../../../service/base.service.dart';

class BulkTransferPage extends StatefulWidget {
  AnimalModel? selectedAnimal;
  final List<AnimalModel> selectedAnimals;

  BulkTransferPage({Key? key, required this.selectedAnimals}) : super(key: key);
  @override
  _BulkTransferPageState createState() => _BulkTransferPageState();
}

class _BulkTransferPageState extends State<BulkTransferPage> {
  List<BuildingModel> buildings = [];
  List<SectionModel> sections = [];
  List<PaddockModel> paddocks = [];
  BuildingModel? selectedBuilding;
  SectionModel? selectedSection;
  PaddockModel? selectedPaddock;

  @override
  void initState() {
    super.initState();
    _fetchBuildings();
  }

  Future<void> _fetchBuildings() async {
    try {
      Response response = await dio.get("Building");
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> responseData = response.data;
        setState(() {
          buildings =
              responseData.map((json) => BuildingModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching buildings'),
        ),
      );
    }
  }

  Future<void> _fetchSections(int buildingId) async {
    try {
      Response response = await dio.get("Section?buildingId=$buildingId");
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> responseData = response.data;
        setState(() {
          sections =
              responseData.map((json) => SectionModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching sections'),
        ),
      );
    }
  }

  Future<void> _fetchPaddocks(int sectionId) async {
    try {
      Response response = await dio.get("Paddock?sectionId=$sectionId");
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> responseData = response.data;
        setState(() {
          paddocks =
              responseData.map((json) => PaddockModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching paddocks'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<BuildingModel>(
              value: selectedBuilding,
              hint: const Text('Bina Seçiniz'),
              items: buildings.map((building) =>
                  DropdownMenuItem(
                    value: building,
                    child: Text(building.description ?? ''),
                  ),
              ).toList(),
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
              items: sections.map((section) =>
                  DropdownMenuItem(
                    value: section,
                    child: Text(section.description ?? ''),
                  ),
              ).toList(),
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
              items: paddocks.map((paddock) =>
                  DropdownMenuItem(
                    value: paddock,
                    child: Text(paddock.description ?? ''),
                  ),
              ).toList(),
              onChanged: (paddock) {
                setState(() {
                  selectedPaddock = paddock;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (widget.selectedAnimal != null) {
                  _transferAnimalToPaddock(selectedPaddock!.id!);
                } else if (widget.selectedAnimals.isNotEmpty) {
                  _transferAnimalsInBulk(selectedPaddock!.id!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen bir hayvan seçin'),
                    ),
                  );
                }
              },
              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }



  void _transferAnimalToPaddock(int paddockId) async {
    if (widget.selectedAnimal != null) {
      try {
        Response response = await dio.put(
          "Animal/UpdateAnimalPaddockTransfer",
          queryParameters: {
            "updateUserId": cachemanager.getItem(0)?.id,
            "newPaddockId": paddockId,
          },
          data: widget.selectedAnimal!.toJson(),
        );
        if (response.statusCode == HttpStatus.ok) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hayvan başarıyla transfer edildi'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context, widget.selectedAnimal);
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen bir hayvan seçin'),
        ),
      );
    }
  }

  void _transferAnimalsInBulk(int paddockId) async {
    for (var animal in widget.selectedAnimals) {
      try {
        Response response = await dio.put(
          "Animal/UpdateAnimalPaddockTransfer",
          queryParameters: {
            "updateUserId": cachemanager.getItem(0)?.id,
            "newPaddockId": paddockId,
          },
          data: animal.toJson(),
        );
        if (response.statusCode != HttpStatus.ok) {
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Seçilen hayvanlar başarıyla transfer edildi'),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }
}