import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../service/base.service.dart';

class EditAnimalPage extends StatefulWidget {
  final AnimalModel animal;

  const EditAnimalPage({Key? key, required this.animal}) : super(key: key);

  @override
  _EditAnimalPageState createState() => _EditAnimalPageState();
}

class _EditAnimalPageState extends State<EditAnimalPage> {
  late String? _selectedType;
  late String _selectedGender;
  late String _earringNumber;
  late DateTime _birthDate;
  late int? _paddockNumber;
  late String _race;
  late String _buildDescription;
  late String? _rfid;
  late int? _animalTypeId;
  final int updateUserId = 1;
  List<String> animalTypes = []; // Hayvan türlerini saklamak için liste

  @override
  void initState() {
    super.initState();
    _selectedType = widget.animal.animalTypeDescription;
    _selectedGender = _formatGender(widget.animal.animalGender);
    _earringNumber = widget.animal.earringNumber ?? '';
    _birthDate = widget.animal.birthDate ?? DateTime.now();
    _paddockNumber = widget.animal.paddockId;
    _race = widget.animal.origin ?? '';
    _buildDescription = widget.animal.buildDescription ?? '';
    _rfid = widget.animal.rfid ?? '';
    _animalTypeId = widget.animal.animalTypeId;
    _fetchAnimalTypes(); // Hayvan türlerini çekmek için metod çağrısı
  }

  // API'den hayvan türlerini çeken metod
  Future<void> _fetchAnimalTypes() async {
    try {
      Response response = await dio.get('api/AnimalType/GetAllAnimalTypes');
      if (response.statusCode == HttpStatus.ok) {
        setState(() {
          // API'den gelen verileri listeye atıyoruz
          animalTypes = List<String>.from(response.data);
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> _saveChanges() async {
    try {
      widget.animal.rfid = _rfid;
      widget.animal.birthDate = _birthDate;
      widget.animal.earringNumber = _earringNumber;
      Response response = await dio.put(
        'Animal/UpdateAnimalInfo?updateUserId=$updateUserId',
        data: widget.animal.toJson(),
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.data is bool && response.data) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Değişiklikler başarıyla kaydedildi'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context); // Önceki sayfaya geri dön
        } else {
          throw Exception('Güncelleme başarısız oldu');
        }
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Değişiklikleri kaydederken hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hayvan Kartını Düzenle'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            onPressed: _saveChanges,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tür'),
              DropdownButton<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                items: animalTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _earringNumber,
                onChanged: (value) {
                  _earringNumber = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Küpe Numarası',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _rfid,
                onChanged: (value) {
                  _rfid = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Rfid',
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _birthDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != _birthDate) {
                    setState(() {
                      _birthDate = pickedDate;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Doğum Tarihi',
                    hintText: 'Doğum Tarihini Seç',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_birthDate.toString().split(' ')[0]),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _race,
                onChanged: (value) {
                  _race = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Menşeii',
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _animalTypeId?.toString() ?? '',
                onChanged: (value) {
                  _animalTypeId = int.tryParse(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Type',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatGender(AnimalGender? gender) {
    switch (gender) {
      case AnimalGender.Feminine:
        return 'Erkek';
      case AnimalGender.Masculine:
        return 'Dişi';
      default:
        return '';
    }
  }
}
