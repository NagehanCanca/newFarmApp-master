import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/base_cache_manager.dart';
import '../../../service/base.service.dart';

class TransferAnimalSelectionPage extends StatefulWidget {
  final int paddockId;

  TransferAnimalSelectionPage({Key? key, required this.paddockId}) : super(key: key);

  @override
  _TransferAnimalSelectionPageState createState() => _TransferAnimalSelectionPageState();
}

class _TransferAnimalSelectionPageState extends State<TransferAnimalSelectionPage> {
  List<AnimalModel> animalList = [];
  List<AnimalModel> selectedAnimals = [];

  @override
  void initState() {
    super.initState();
    _fetchAnimals(widget.paddockId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hayvan Seçimi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_box_outlined),
            onPressed: () {
              setState(() {
                if (selectedAnimals.length < animalList.length) {
                  selectedAnimals = List.from(animalList);
                } else {
                  selectedAnimals.clear();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => _transferSelectedAnimals(),
          ),
        ],
      ),
      body: _buildAnimalList(),
    );
  }

  Widget _buildAnimalList() {
    return ListView.builder(
      itemCount: animalList.length,
      itemBuilder: (context, index) {
        final animal = animalList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            onTap: () {
              setState(() {
                if (selectedAnimals.contains(animal)) {
                  selectedAnimals.remove(animal);
                } else {
                  selectedAnimals.add(animal);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: selectedAnimals.contains(animal),
                    onChanged: (_) {
                      setState(() {
                        if (selectedAnimals.contains(animal)) {
                          selectedAnimals.remove(animal);
                        } else {
                          selectedAnimals.add(animal);
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.pets, size: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('RFID: ${animal.rfid}', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Küpe No: ${animal.earringNumber}', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Durum: ${animal.animalStatus.toString().split('.').last}', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Giriş Tarihi: ${_formatDate(animal.farmInsertDate!)}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  Future<void> _fetchAnimals(int paddockID) async {
    try {
      Response response = await dio.get("Animal/GetAllByPaddockId",
        queryParameters: {
          "paddockID": paddockID,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          animalList = responseData.map((json) => AnimalModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching animal list'),
        ),
      );
    }
  }

  void _transferSelectedAnimals() async {
    if (selectedAnimals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen en az bir hayvan seçiniz.'),
        ),
      );
      return;
    }

    for (AnimalModel animal in selectedAnimals) {
      try {
        Response response = await dio.put(
          "Animal/UpdateAnimalPaddockTransfer",
          queryParameters: {
            "updateUserId": cachemanager.getItem(0)?.id,
            "newPaddockId": widget.paddockId, // Kullanıcının seçtiği paddockId
          },
          data: animal.toJson(),
        );
        if (response.statusCode == HttpStatus.ok) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hayvan başarıyla transfer edildi'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context, animal);
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

    // Transfer işlemi tamamlandıktan sonra seçilen hayvanların listesini temizle
    setState(() {
      selectedAnimals.clear();
    });
  }
}
