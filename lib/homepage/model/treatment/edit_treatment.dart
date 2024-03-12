import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/treatment_model.dart';
import '../../../service/base.service.dart';

class EditTreatmentPage extends StatefulWidget {
  final AnimalModel animal;
  final TreatmentModel treatment;

  const EditTreatmentPage({Key? key, required this.animal, required this.treatment}) : super(key: key);

  @override
  _EditTreatmentPageState createState() => _EditTreatmentPageState();
}

class _EditTreatmentPageState extends State<EditTreatmentPage> {
  late DateTime _selectedDate;
  late TextEditingController _diagnosisController;
  late TextEditingController _descriptionController;
  String? _selectedDiagnosis;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.treatment.date;
    _diagnosisController = TextEditingController(text: widget.treatment.diseaseDiagnoseId.toString());
    _descriptionController = TextEditingController(text: widget.treatment.diseaseDiagnoseDescription);
    _selectedDiagnosis = widget.treatment.diseaseDiagnoseId.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tedavi Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hayvan Bilgileri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildAnimalInfoFields(),
            const SizedBox(height: 20),
            const Text(
              'Tedavi Bilgileri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTreatmentFields(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _endTreatment,
                  child: Text('Tedaviyi Sonlandır'),
                ),
                ElevatedButton(
                  onPressed: _saveTreatment,
                  child: Text('Kaydet'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimalInfoFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Küpe No: ${widget.animal.earringNumber}'),
        Text('Durumu: ${widget.animal.animalStatus}'),
        Text('Çiftliğe Giriş Tarihi: ${widget.animal.farmInsertDate.toString().split(' ')[0]}'),
        Text('Padok: ${widget.animal.paddockId}'),
      ],
    );
  }

  Widget _buildTreatmentFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _pickDate,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_selectedDate.toString().split(' ')[0]),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<String>>(
          future: _fetchDiagnoses(), // API'den verileri alıyoruz
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else {
              return DropdownButtonFormField<String>(
                value: _selectedDiagnosis,
                onChanged: (value) {
                  setState(() {
                    _selectedDiagnosis = value;
                  });
                },
                items: snapshot.data!.map((diagnosis) {
                  return DropdownMenuItem<String>(
                    value: diagnosis,
                    child: Text(diagnosis),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Tanı'),
              );
            }
          },
        ),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Not'),
        ),
      ],
    );
  }

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<List<String>> _fetchDiagnoses() async {
    try {
      Response response = await dio.get(
          'Treatment/GetAllTreatmentDiagnoses'
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        List<String> diagnoses = responseData.map((item) => item.toString()).toList();
        return diagnoses;
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('Veri alınırken bir hata oluştu');
    }
  }

  void _endTreatment() {
    // Tedavinin sonlandırılması işlemleri burada yapılacak.
  }

  void _saveTreatment() async {
    try {
      Response response = await dio.put(
        'Treatment/UpdateTreatmentInfo',
        data: {
          'id': widget.treatment.id,
          'date': _selectedDate,
          'diagnosisId': _selectedDiagnosis,
          'description': _descriptionController.text,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tedavi bilgileri başarıyla güncellendi'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context); // Önceki sayfaya geri dön
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tedavi bilgileri güncellenirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
