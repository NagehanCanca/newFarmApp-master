import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/base_cache_manager.dart';
import 'package:farmsoftnew/model/disease_diagnose_model.dart';
import 'package:farmsoftnew/model/treatment_model.dart';
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
  late List<DiseaseDiagnoseModel> diseaseDiagnose = [];
  late TextEditingController _treatmentDateController;
  late TextEditingController _diagnosisController;
  late TextEditingController _descriptionController;
  String? _selectedTreatmentStatus;
  DiseaseDiagnoseModel? _selectedDiagnosis;
  DateTime? _selectedDate;
  List<String> _treatmentStatusList = [
    'Yeni Tedavi',
    'Sonlanmış Tedavi',
  ];

  @override
  void initState() {
    super.initState();
    _fetchDiagnoses();
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
              const SizedBox(height: 20),
              const Text(
                'Tedavi Bilgileri',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTreatmentFields(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTreatment,
                child: const Text('Tedaviyi Kaydet'),
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
        DropdownButtonFormField<String>(
          value: _selectedTreatmentStatus,
          hint: const Text('Tedavi Durumu Seçiniz'),
          items: _treatmentStatusList.map((String status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Text(status),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedTreatmentStatus = value!;
            });
          },
        ),
        GestureDetector(
          onTap: _selectDate,
          child: AbsorbPointer(
            child: TextField(
              controller: _treatmentDateController,
              decoration: const InputDecoration(labelText: 'Tarih'),
            ),
          ),
        ),
        const Text('Tür'),
        _buildDiseaseList(),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: 'Not'),
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
        _selectedDate = picked;
      });
    }
  }

  Future<void> _fetchDiagnoses() async {
    try {
      Response response = await dio.get('DiseaseDiagnose/GetAllDiseaseDiagnoses');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
       setState(() {
         diseaseDiagnose = responseData.map((json) => DiseaseDiagnoseModel.fromJson(json))
             .toList();
       });

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
          data: TreatmentModel (
            animalID:  widget.animal.id!,
            treatmentStatus: TreatmentStatus.NewTreatment,
            date:_selectedDate!,
            diseaseDiagnoseId:_selectedDiagnosis!.id,
           insertUser: cachemanager.getItem(0)!.id!,
            notes:_descriptionController.text,
          ).toJson(),
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
  Widget _buildDiseaseList() {
    return ListTile(
      title: Text('Tanı seçiniz'),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              itemCount: diseaseDiagnose.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(diseaseDiagnose[index].name ?? ''),
                  onTap: () {
                    setState(() {
    _selectedDiagnosis = diseaseDiagnose[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

}
