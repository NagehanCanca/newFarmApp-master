import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../service/base.service.dart';

class NewTreatmentPage extends StatefulWidget {
  final AnimalModel animal;

  const NewTreatmentPage({Key? key, required this.animal}) : super(key: key);

  @override
  _NewTreatmentPageState createState() => _NewTreatmentPageState();
}

class _NewTreatmentPageState extends State<NewTreatmentPage> {
  late TextEditingController _statusController;
  late TextEditingController _entryDateController;
  late TextEditingController _earringNumberController;
  late TextEditingController _corralNameController;
  late TextEditingController _treatmentStatusController;
  late TextEditingController _treatmentDateController;
  late TextEditingController _diagnosisController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController();
    _entryDateController = TextEditingController();
    _earringNumberController = TextEditingController(text: widget.animal.earringNumber);
    _corralNameController = TextEditingController();
    _treatmentStatusController = TextEditingController();
    _treatmentDateController = TextEditingController();
    _diagnosisController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Tedavi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hayvan Bilgileri',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildAnimalInfoFields(),
              SizedBox(height: 20),
              const Text(
                'Tedavi Bilgileri',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildTreatmentFields(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTreatment,
                child: Text('Tedaviyi Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimalInfoFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Durumu',
          ),
          controller: TextEditingController(text: getStatusText(widget.animal.animalStatus!)),
        ),
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Çiftliğe Giriş Tarihi',
          ),
          controller: TextEditingController(text: widget.animal.farmInsertDate.toString().split(' ')[0]),
        ),
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Küpe No',
          ),
          controller: TextEditingController(text: widget.animal.earringNumber),
          enabled: false,
        ),
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Padok',
          ),
          controller: TextEditingController(text: widget.animal.paddockDescription),
          enabled: false,
        ),
      ],
    );
  }


  Widget _buildTreatmentFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _treatmentStatusController,
          decoration: InputDecoration(labelText: 'Tedavi Durumu'),
        ),
        GestureDetector(
          onTap: _selectDate,
          child: AbsorbPointer(
            child: TextField(
              controller: _treatmentDateController,
              decoration: InputDecoration(labelText: 'Tarih'),
            ),
          ),
        ),
        GestureDetector(
          onTap: _showDiagnosesBottomSheet,
          child: AbsorbPointer(
            child: TextField(
              controller: _diagnosisController,
              decoration: InputDecoration(labelText: 'Tanı'),
            ),
          ),
        ),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Not'),
        ),
      ],
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _treatmentDateController.text = picked.toString().split(' ')[0];
      });
    }
  }
  void _showDiagnosesBottomSheet() async {
    List<String> diagnoses = await _fetchDiagnoses();

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: diagnoses.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(diagnoses[index]),
                onTap: () {
                  Navigator.pop(context, diagnoses[index]);
                },
              );
            },
          ),
        );
      },
    ).then((selectedDiagnosis) {
      if (selectedDiagnosis != null) {
        _diagnosisController.text = selectedDiagnosis;
      }
    });
  }
  Future<List<String>> _fetchDiagnoses() async {
    try {
      Response response = await dio.get('DiseaseDiagnose/GetAllDiseaseDiagnoses');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        List<String> diagnoses = responseData.map((item) => item['name'].toString()).toList();
        return diagnoses;
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('Veri alınırken bir hata oluştu');
    }
  }

  void _submitTreatment() async {
      try {
        Response response = await dio.post(
          'Treatment/AddAnimalTreatment',
          data: {
            'animalId': widget.animal.id,
            'treatmentStatus': _treatmentStatusController.text,
            'treatmentDate': _treatmentDateController.text,
            'diagnosis': _diagnosisController.text,
            'description': _descriptionController.text,
          },
        );
        if (response.statusCode == HttpStatus.ok) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tedavi başlatıldı.'),
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
            content: Text('Tedavi başlatılırken bir hata oluştu'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  String getStatusText(AnimalStatus status) {
    switch (status) {
      case AnimalStatus.Normal:
        return 'Normal';
      case AnimalStatus.Ill:
        return 'Hasta';
      case AnimalStatus.Sold:
        return 'Satıldı';
      case AnimalStatus.Ex:
        return 'Ölü';
      default:
        return 'Bilinmiyor';
    }
  }

}
