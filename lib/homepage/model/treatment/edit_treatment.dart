import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/base_cache_manager.dart';
import 'package:farmsoftnew/model/disease_diagnose_model.dart';
import 'package:farmsoftnew/model/product_unit_model.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/treatment_model.dart';
import '../../../model/treatment_note_model.dart';
import '../../../model/treatment_product_model.dart';
import '../../../service/base.service.dart';

class EditTreatmentPage extends StatefulWidget {
  final TreatmentModel treatment;

  const EditTreatmentPage({
    Key? key,
    required this.treatment,
  }) : super(key: key);

  @override
  _EditTreatmentPageState createState() => _EditTreatmentPageState();
}

class _EditTreatmentPageState extends State<EditTreatmentPage> {
  late DateTime _selectedDate;
  late TextEditingController _diagnosisController;
  late TextEditingController _descriptionController;
  late int _selectedDiagnosis;
  late AnimalModel selectedAnimal = AnimalModel();
  late List<DiseaseDiagnoseModel> _diagnoses;
  late TextEditingController _noteController;
  late TextEditingController _productController;
  late ProductUnitModel unitModel;
  late int _treatmentId;
  late int _noteId;
  late TreatmentProductModel? treatmentProduct = null;
  late int _animalId;
  late double _quantity;
  late int _unitId;
// Ilac bilgilerini tutan değişkenler
  late List<TreatmentProductModel> medications = [];
  late List<ProductUnitModel> units = [];
  late TextEditingController _customProductController = TextEditingController();
  late TextEditingController _customQuantityController = TextEditingController();
  late int _selectedUnitId = 0;
  late ProductUnitModel? _unitModel;


  @override
  void initState() {
    super.initState();
    _fetchAnimal();
    _selectedDate = widget.treatment.date;
    _diagnosisController = TextEditingController(
        text: widget.treatment.diseaseDiagnoseId.toString());
    _descriptionController = TextEditingController(
        text: widget.treatment.notes);
    _selectedDiagnosis = widget.treatment.diseaseDiagnoseId ?? 0;
    _noteController = TextEditingController();
    _productController = TextEditingController();
    _treatmentId = widget.treatment.id ?? 0;
    _animalId = widget.treatment.animalID ?? 0;
    _quantity = treatmentProduct?.quantity ?? 0;
    _unitId = treatmentProduct?.unitId ?? 0;
    _fetchMedications(_treatmentId);
    _fetchProductUnits().then((value) {
      if (units.isNotEmpty) {
        setState(() {
          _unitModel = units.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedavi Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hayvan Bilgileri',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimalInfoFields(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tedavi Bilgileri',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTreatmentFields(),
                    const SizedBox(height: 20),
                    FutureBuilder<List<TreatmentProductModel>>(
                      future: _fetchMedications(_treatmentId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Hata: ${snapshot.error}');
                        } else if (snapshot.data == null) {
                          return Text('Veri yok');
                        } else {
                          List<TreatmentProductModel> medications = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<TreatmentProductModel>(
                                value: treatmentProduct,
                                items: medications.map((medication) {
                                  return DropdownMenuItem<TreatmentProductModel>(
                                    value: medication,
                                    child: Text(medication.productDescription),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    treatmentProduct = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'İlaç',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<ProductUnitModel>(
                                value: unitModel,
                                items: _buildUnitDropdownItems(),
                                onChanged: (value) {
                                  setState(() {
                                    unitModel = value!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Birim',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _customQuantityController,
                                decoration: const InputDecoration(
                                  labelText: 'Miktar',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _quantity = double.parse(value);
                                },
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: _addMedication,
                                    child: const Text('Ekle'),
                                  ),
                                  ElevatedButton(
                                    onPressed: _deleteMedication,
                                    child: const Text('Sil'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              TextField(
                                controller: _noteController,
                                decoration: const InputDecoration(labelText: 'Not'),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Butonları eşit aralıklarla yerleştirir
                                children: [
                                  ElevatedButton(
                                    onPressed: _addNote,
                                    child: const Text('Ekle'),
                                  ),
                                  ElevatedButton(
                                    onPressed: _deleteNote,
                                    child: const Text('Sil'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _endTreatment,
                                      child: const Text('Tedaviyi Sonlandır'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange,
                                        minimumSize: const Size(double.infinity, 40), // Genişlik ve yükseklik ayarları
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                      }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<ProductUnitModel>> _buildUnitDropdownItems() {
    if (_unitModel == null) {
      return [];
    } else {
      return units.map((unit) {
        return DropdownMenuItem<ProductUnitModel>(
          value: unit,
          child: Text(unit.unitId.toString()),
        );
      }).toList();
    }
  }

  void _addMedication() async {
    try {
      treatmentProduct?.treatmentId = _treatmentId;
      treatmentProduct?.unitId = _unitId;
      treatmentProduct?.animalId = _animalId;
      treatmentProduct?.insertUser = cachemanager.getItem(0)!.id!;
      treatmentProduct?.quantity = _quantity;
      Response response = await dio.post(
        'TreatmentProduct/AddTreatmentProduct',
          data: treatmentProduct!.toJson(),

      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İlaç başarıyla eklendi'),
            duration: Duration(seconds: 2),
          ),
        );
        // İlaç eklendikten sonra ilaç listesini yenilemek için gerekli kodu buraya ekle
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İlaç eklenirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteMedication() async {
    try {
      if (treatmentProduct != null) {
        int? productId = treatmentProduct!.id;

        if (productId != null) {
          Response response = await dio.delete(
            'TreatmentProduct/DeleteTreatmentProduct',
          );

          if (response.statusCode == HttpStatus.ok) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('İlaç başarıyla silindi'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            throw Exception('HTTP Hatası ${response.statusCode}');
          }
        } else {
          throw Exception('İlaç id boş olamaz');
        }
      } else {
        throw Exception('TreatmentProduct boş olamaz');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İlaç silinirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _fetchProductUnits() async {
    try {
      Response response = await dio.get(
        'ProductUnit/GetAllProductUnits',
      );

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        units = responseData
            .map((json) => ProductUnitModel.fromJson(json))
            .toList();
        setState(() {});
      } else {
        throw Exception('HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching product units');
    }
  }

  Future<List<TreatmentProductModel>> _fetchMedications(int treatmentId) async {
    try {
      Response response = await dio.get(
        'TreatmentProduct/GetAllTreatmentProducts',
        queryParameters: {'treatmentId': treatmentId},
      );

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        List<TreatmentProductModel> medications = responseData
            .map((json) => TreatmentProductModel.fromJson(json))
            .toList();
        return medications;
      } else {
        throw Exception('HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching medications');
    }
  }


  void _addNote() async {
    try {

      Response response = await dio.post(
        'TreatmentNote/AddTreatmentNote',
        data: TreatmentNoteModel(treatmentId: widget.treatment.id, date: DateTime.now(),
            notes: _noteController.text, insertUser: cachemanager.getItem(0)!.id!));

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Not başarıyla eklendi'),
            duration: Duration(seconds: 2),
          ),
        );
        // Not eklendikten sonra not listesini yenilemek için gerekli kodu buraya ekle
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not eklenirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteNote() async {
    try {
      Response response = await dio.delete(
        'TreatmentNote/DeleteTreatmentNote',
        queryParameters: {'id': _noteId},
      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Not başarıyla silindi'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not silinirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
          controller: TextEditingController(
              text: selectedAnimal.animalStatus.toString() ?? ''),
          enabled: false,
        ),
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Çiftliğe Giriş Tarihi',
          ),
          controller: TextEditingController(
              text: selectedAnimal.farmInsertDate?.toString().split(' ')[0] ??
                  ''),
          enabled: false,
        ),
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Küpe No',
          ),
          controller: TextEditingController(
              text: selectedAnimal.earringNumber ?? ''),
          enabled: false,
        ),
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Padok',
          ),
          controller: TextEditingController(
              text: selectedAnimal.paddockDescription ?? ''),
          enabled: false,
        ),
      ],
    );
  }

  void _showDiagnosesBottomSheet(List<String> diagnoses) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: diagnoses.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(diagnoses[index]),
                onTap: () {
                  setState(() {
                    _selectedDiagnosis = _diagnoses
                        .where((element) => element.name == diagnoses[index])
                        .first
                        .id;
                  });
                  Navigator.pop(context); // BottomSheet'i kapat
                },

              );
            },
          ),
        );
      },
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
        FutureBuilder<List<DiseaseDiagnoseModel>>(
          future: _fetchDiagnoses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else {
              List<DiseaseDiagnoseModel> diagnoses = snapshot.data!;
              return InkWell(
                onTap: () {
                  _showDiagnosesBottomSheet(
                      diagnoses.map((e) => e.name).toList());
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tanı Seçin',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(diagnoses
                          .firstWhere((element) =>
                      element.id == _selectedDiagnosis)
                          .name ?? 'Tanı Seçilmedi'),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: 'Not'),
        ),
        const SizedBox(height: 12),
        const SizedBox(height: 20), // Aradaki mesafeyi ayarlayan SizedBox
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _saveTreatment,
                child: const Text('Kaydet'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40), // Genişlik ve yükseklik ayarları
                ),
              ),
            ),
          ],
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

  Future<List<DiseaseDiagnoseModel>> _fetchDiagnoses() async {
    try {
      Response response =
      await dio.get('DiseaseDiagnose/GetAllDiseaseDiagnoses');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;

        _diagnoses = responseData
            .map((json) => DiseaseDiagnoseModel.fromJson(json))
            .toList();
        return _diagnoses;
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('Veri alınırken bir hata oluştu');
    }
  }

  Future<void> _fetchAnimal() async {
    try {
      Response response =
      await dio.get('Animal/GetAnimalByRfIdOrEarringNumber',
          queryParameters: {
            "identityNumber": widget.treatment.animalEarringNumber,
          });

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        if (responseData.isNotEmpty) {
          AnimalModel animal = AnimalModel.fromJson(responseData.first);
          setState(() {
            selectedAnimal = animal;
          });
        }
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('Veri alınırken bir hata oluştu');
    }
  }

  void _saveTreatment() async {
    try {
      widget.treatment.date = _selectedDate;
      widget.treatment.diseaseDiagnoseId = _selectedDiagnosis ?? 0;
      widget.treatment.notes = _descriptionController.text;

      Response response = await dio.put(
        'Treatment/UpdateAnimalTreatment',
        data: widget.treatment.toJson(),
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

  void _endTreatment() async {
    try {
        widget.treatment.id = _treatmentId;

      Response response = await dio.post(
        'Treatment/EndTreatment',
        data: widget.treatment.toJson(),
      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tedavi başarıyla sonlandırıldı'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tedavi sonlandırılırken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}