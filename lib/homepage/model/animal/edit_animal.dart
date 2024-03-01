import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/animal_type_model.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../service/base.service.dart';

class EditAnimalPage extends StatefulWidget {
  final AnimalModel animal;
  final List<AnimalTypeModel> animalType;

  const EditAnimalPage({Key? key, required this.animal,required this.animalType }) : super(key: key);

  @override
  _EditAnimalPageState createState()  => _EditAnimalPageState();
}

class _EditAnimalPageState extends State<EditAnimalPage> {

  late String _selectedGender;
  late String _earringNumber;
  late DateTime _birthDate;
  late int? _paddockNumber;
  late String _race;
  late String _buildDescription;
  late String? _rfid;
  final int updateUserId = 1;

  late int _selectedTypeId;
  @override
  void initState() {

    super.initState();

    _selectedTypeId = widget.animal.animalTypeId ?? 0;
    _selectedGender = _formatGender(widget.animal.animalGender);
    _earringNumber = widget.animal.earringNumber ?? '';
    _birthDate = widget.animal.birthDate ?? DateTime.now();
    _paddockNumber = widget.animal.paddockId;
    _race = widget.animal.origin ?? '';
    _buildDescription = widget.animal.buildDescription ?? '';
    _rfid = widget.animal.rfid ?? '';



    // Hayvan türlerini çek

  }

  @override
  Widget build(BuildContext context)  {
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
              _buildTypeDropdown(), // Hayvan türleri dropdown menüsü
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
                    // setState(() {
                    //   _birthDate = pickedDate;
                    // });
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
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _saveChanges() async {
    try {

        widget.animal.rfid = _rfid;
        widget.animal.birthDate = _birthDate;
        widget.animal.earringNumber = _earringNumber;
      // _selectedType'ı kullanarak _animalTypeId değerini güncelle

        widget.animal.animalTypeId =  widget.animalType.where((element) => element.id == _selectedTypeId).map((e) => e.id) as int?;


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

  Widget _buildTypeDropdown() {
    return DropdownButton<int>(
      value: _selectedTypeId,
      onChanged: (int? value) {
        setState(() {
          _selectedTypeId = value!;
        });
      },
      items: widget.animalType.map<DropdownMenuItem<int>>((AnimalTypeModel type) {
        return DropdownMenuItem<int>(
          value: type.id ?? 0,
          child: Text(type.description ?? ''),
        );
      }).toList(),
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