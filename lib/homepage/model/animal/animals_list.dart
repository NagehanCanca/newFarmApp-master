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
        title: const Text('Hayvan Listesi'),
        actions: [],
      ),
      body: _buildAnimalList(),
    );
  }

  Widget _buildAnimalList() {
    return ListView.builder(
      itemCount: animalList.length,
      itemBuilder: (context, index) {
        final animal = animalList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnimalCard(animal: animal),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.pets, size: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('RFID: ${animal.rfid}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Küpe No: ${animal.earringNumber}', style: const TextStyle(fontSize: 16)),
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
}
