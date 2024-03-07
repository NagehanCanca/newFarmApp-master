import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../service/base.service.dart';
import 'animal_card_test.dart';

class AnimalsListPage extends StatefulWidget {
  final int paddockId;

  const AnimalsListPage({super.key, required this.paddockId});
  @override
  _AnimalsListPageState createState() => _AnimalsListPageState();
}

class _AnimalsListPageState extends State<AnimalsListPage> {
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
        title: Text('Animals List'),
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
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalCard(animal: animal),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: selectedAnimals.contains(animal),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null && value) {
                          selectedAnimals.add(animal);
                        } else {
                          selectedAnimals.remove(animal);
                        }
                      });
                    },
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.pets, size: 48),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('RFID: ${animal.rfid}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Küpe No: ${animal.earringNumber}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Durum: ${animal.animalStatus.toString().split('.').last}', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
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
  void _bulkVaccination() async {
    if (selectedAnimals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Toplu aşılama için en az bir hayvan seçiniz.'),
        ),
      );
      return;
    }

    try {
      // Seçilen hayvanlar için toplu aşılama işlemini burada gerçekleştirin
      // Seçilen hayvanları aşılamak için selectedAnimals listesini kullanabilirsiniz
      // API çağrısı veya başka bir işlem yapabilirsiniz

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seçilen hayvanlar için toplu aşılama başlatıldı.'),
        ),
      );

      // Aşılamadan sonra seçilen hayvanlar listesini temizle
      setState(() {
        selectedAnimals.clear();
      });
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Toplu aşılama işlemi sırasında hata oluştu.'),
        ),
      );
    }
  }
}
