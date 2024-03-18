import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/treatment/edit_treatment.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/treatment_model.dart';
import '../../../model/treatment_note_model.dart';
import '../../../model/treatment_product_model.dart';
import '../../../service/base.service.dart';

class TreatmentPage extends StatefulWidget {
  final TreatmentNoteModel? treatmentNote;
  final TreatmentProductModel? treatmentProduct;

  const TreatmentPage({
    Key? key,
    this.treatmentNote,
    this.treatmentProduct,
  }) : super(key: key);

  @override
  _TreatmentPageState createState() => _TreatmentPageState();
}

class _TreatmentPageState extends State<TreatmentPage> {
  late List<TreatmentModel> _treatments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

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
    return FutureBuilder<void>(
      future:  _fetchTreatmentsForAnimal(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
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
                          Text(
                            'Tedavi Durumu: ${treatment.treatmentStatus.toString().split('.').last ?? ""}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Açıklama: ${treatment.diseaseDiagnoseDescription ?? ""}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }



  Future<void> _fetchTreatmentsForAnimal() async {
    try {
      Response response = await dio.get("Treatment/GetAllTreatmentAnimals");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;

          _treatments = responseData
              .map((json) => TreatmentModel.fromJson(json))
              .toList();
          _isLoading = false;
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
        builder: (context) => EditTreatmentPage(

          treatment: treatment,
          treatmentNote: widget.treatmentNote,
          treatmentProduct: widget.treatmentProduct,
        ),
      ),
    );
    _fetchTreatmentsForAnimal();
  }
}
