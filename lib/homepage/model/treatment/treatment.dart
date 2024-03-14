import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/animal/animal_test.dart';
import 'package:farmsoftnew/homepage/model/treatment/edit_treatment.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/treatment_model.dart';
import '../../../model/treatment_note_model.dart';
import '../../../model/treatment_product_model.dart';
import '../../../service/base.service.dart';

class TreatmentPage extends StatefulWidget {
  final List<AnimalModel> selectedAnimals;
  final TreatmentNoteModel? treatmentNote;
  final TreatmentProductModel? treatmentProduct;

  const TreatmentPage({Key? key, required this.selectedAnimals, this.treatmentNote, this.treatmentProduct}) : super(key: key);

  @override
  _TreatmentPageState createState() => _TreatmentPageState();
}

class _TreatmentPageState extends State<TreatmentPage> {
  late List<TreatmentModel> _treatments = [];
  List<AnimalModel> selectedAnimals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTreatmentsForSelectedAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedavi Bilgileri'),
      ),
      body: _buildTreatmentTable(),
    );
  }

  Widget _buildTreatmentTable() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _treatments.length,
        itemBuilder: (context, index) {
          final treatment = _treatments[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => AnimalCard(animal: widget.animal),
              //     ),
              //   );
              // },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Küpe No: ${treatment.animalEarringNumber ?? ""}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _editTreatment(treatment);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Text('Tarih: ${_formatDate(treatment.date)}', style: const TextStyle(fontSize: 16)),
                    // const SizedBox(height: 8),
                    Text('Tedavi Durumu: ${treatment.treatmentStatus.toString().split('.').last ?? ""}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    // Text('Padok Adı: ${treatment.paddockName ?? ""}', style: const TextStyle(fontSize: 16)),
                    // const SizedBox(height: 8),
                    // Text('Tanı: ${treatment.diseaseDiagnoseId ?? ""}', style: const TextStyle(fontSize: 16)),
                    // const SizedBox(height: 8),
                    Text('Açıklama: ${treatment.diseaseDiagnoseDescription ?? ""}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
    } else {
      return '';
    }
  }

  Future<void> _fetchTreatmentsForSelectedAnimals() async {
    try {
      Response response = await dio.get(
          "Treatment/GetAllTreatmentAnimals"
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          _treatments = responseData
              .map((json) => TreatmentModel.fromJson(json))
              .toList();
          _isLoading = false;
        });
      } else {
        throw Exception('HTTP Hatası: ${response.statusCode}');
      }
    } catch (e) {
      print('Tedaviler alınırken hata oluştu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tedavi bilgileri alınamadı'),
        ),
      );
    }
  }

  void _editTreatment(TreatmentModel treatment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        //builder: (context) => EditTreatmentPage(
        builder: (context) => AnimalTestScreen(
          // animal: AnimalModel(),
          // treatment: treatment,
        ),
      ),
    );
  }
}
