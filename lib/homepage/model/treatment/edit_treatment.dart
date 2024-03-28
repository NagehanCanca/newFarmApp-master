import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/treatment/notes_medications.dart';
import 'package:farmsoftnew/model/base_cache_manager.dart';
import 'package:farmsoftnew/model/disease_diagnose_model.dart';
import 'package:farmsoftnew/model/product_unit_model.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/product_model.dart';
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
  late TextEditingController _descriptionController;
  late int _selectedDiagnosis;
  late AnimalModel selectedAnimal = AnimalModel();
  late List<DiseaseDiagnoseModel> _diagnoses;
  late TextEditingController _noteController;
  late int _treatmentId;
  late double _quantity;
  late int _unitId;
  int? _animalId;
  TextEditingController _customQuantityController = TextEditingController();
  ProductModel? _selectedProductId;
  ProductUnitModel? _unitModel;
  List<ProductModel> medications = [];
  List<ProductUnitModel> _units = [];
  TreatmentProductModel? treatmentProduct = TreatmentProductModel();
  TreatmentNoteModel? treatmentNote;

  @override
  void initState() {
    super.initState();
    _fetchAnimal();
    _selectedDate = widget.treatment.date;
    _descriptionController =
        TextEditingController(text: widget.treatment.notes);
    _selectedDiagnosis = widget.treatment.diseaseDiagnoseId;
    _noteController = TextEditingController();
    _treatmentId = widget.treatment.id ?? 0;
    _animalId = widget.treatment.animalID;
    _quantity = treatmentProduct?.quantity ?? 0;
    _unitId = treatmentProduct?.unitId ?? 0;
    _fetchMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedavi Düzenle'),
        actions: [
          IconButton(
            icon: Icon(Icons.notes),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesAndMedicationsPage(),
                ),
              );
            },
          ),
        ],
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
                    DropdownButtonFormField<ProductModel>(
                      value: _selectedProductId,
                      hint: const Text('İlaç Seçiniz'),
                      items: medications
                          ?.map((medications) => DropdownMenuItem(
                        value: medications,
                        child: Text(medications.description ?? ''),
                      ))
                          .toList(),
                      onChanged: (medications) {
                        setState(() {
                          _selectedProductId = medications;
                          _unitModel = null;
                          _units?.clear();
                          if (medications != null) {
                            _fetchProductUnits();
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'İlaç',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<ProductUnitModel>(
                      value: _unitModel,
                      hint: const Text('Birim Seçiniz'),
                      items: _units
                          ?.map((_units) => DropdownMenuItem(
                        value: _units,
                        child: Text(_units.description ?? ''),
                      ))
                          .toList(),
                      onChanged: (_units) {
                        setState(() {
                          _unitModel = _units;
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
                      ],
                    ),
                    TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(labelText: 'Not'),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _addNote,
                          child: const Text('Ekle'),
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
                              minimumSize: const Size(double.infinity,
                                  40), // Genişlik ve yükseklik ayarları
                            ),
                          ),
                        ),
                      ],
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
              text: getStatusText(selectedAnimal.animalStatus!) ?? ''),
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
          controller:
          TextEditingController(text: selectedAnimal.earringNumber ?? ''),
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
                          .firstWhere(
                              (element) => element.id == _selectedDiagnosis)
                          .name ??
                          'Tanı Seçilmedi'),
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
                  minimumSize: const Size(
                      double.infinity, 40), // Genişlik ve yükseklik ayarları
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addMedication() async {
    try {
      if (_selectedProductId != null) {
        treatmentProduct?.productId = _selectedProductId!.id;
      }
      if (treatmentProduct != null) {
        treatmentProduct?.treatmentId = _treatmentId;
        treatmentProduct?.insertUser = cachemanager.getItem(0)!.id!;
        treatmentProduct?.unitId = _unitId;
        treatmentProduct?.quantity = _quantity;
        treatmentProduct?.animalId = _animalId;
        if (_quantity <= 0 || _unitModel == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lütfen miktar ve birim giriniz.'),
              duration: Duration(seconds: 2),
            ),
          );
          return; // Miktar veya birim girilmedi, işlemi sonlandır
        }
      }
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

  Future<void> _fetchProductUnits() async {
    try {
      Response response = await dio.get(
        'ProductUnit/GetAllProductUnits',
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          _units = responseData
              .map((json) => ProductUnitModel.fromJson(json))
              .toList();
        });
      } else {
        throw Exception('HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching product units');
    }
  }

  Future<void> _fetchMedications() async {
    try {
      Response response = await dio.get(
        'Product/GetAllProducts',
      );

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          medications =
              responseData.map((json) => ProductModel.fromJson(json)).toList();
        });
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
      Response response = await dio.post('TreatmentNote/AddTreatmentNote',
          data: TreatmentNoteModel(
              treatmentId: widget.treatment.id!,
              date: DateTime.now(),
              notes: _noteController.text,
              insertUser: cachemanager.getItem(0)!.id!).toJson());

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
      Response response = await dio.get(
        'Animal/GetAnimalByRfIdOrEarringNumber',
        queryParameters: {
          "identityNumber": widget.treatment.animalEarringNumber,
        },
      );
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
      widget.treatment.updateUser = cachemanager.getItem(0)!.id!;
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