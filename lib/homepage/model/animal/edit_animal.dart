import 'dart:io';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/animal_type_model.dart';
import 'package:farmsoftnew/model/base_cache_manager.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/animal_race_model.dart';
import '../../../service/base.service.dart';

class EditAnimalPage extends StatefulWidget {
  final AnimalModel animal;

  const EditAnimalPage({Key? key, required this.animal}) : super(key: key);

  @override
  _EditAnimalPageState createState()  => _EditAnimalPageState();
}

class _EditAnimalPageState extends State<EditAnimalPage> {

  AnimalGender? _selectedGender;
  late String _earringNumber;
  late DateTime _birthDate;
  late int? _paddockNumber;
  late List<AnimalTypeModel> animalType = [];
  late List<AnimalRaceModel> animalRace = [];
  late String _buildDescription;
  late String? _rfid;
  late int _selectedTypeId;
  late int _selectedRaceId;
  AnimalTypeModel? _selectedType;
  AnimalRaceModel? _selectedRace;

  @override
  void initState() {

    super.initState();
    _fetchAnimalTypes();
    _fetchAnimalRaces();
    _selectedRaceId = widget.animal.animalRaceId?? 0;
    _selectedTypeId = widget.animal.animalTypeId ?? 0;
    _selectedGender = widget.animal.animalGender;
    _earringNumber = widget.animal.earringNumber ?? '';
    _birthDate = widget.animal.birthDate ?? DateTime.now();
    _paddockNumber = widget.animal.paddockId;
    _buildDescription = widget.animal.buildDescription ?? '';
    _rfid = widget.animal.rfid ?? '';
    _selectedType = animalType.firstWhereOrNull((element) => element.id == _selectedTypeId); // _selectedType ataması yapıldı
    _selectedRace = animalRace.firstWhereOrNull((element) => element.id == _selectedRaceId);

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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(''),
            _buildGenderList(), // Cinsiyet seçimi
            const SizedBox(height: 12),
            const Text('Tür'),
            _buildTypeList(), // Hayvan türleri dropdown menüsü
            const SizedBox(height: 12),
            const Text('Irk'),
            _buildRaceList(),
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
          ],
        ),
      ),
    );
  }


  Future<void> _saveChanges() async {
    try {
        widget.animal.rfid = _rfid;
        widget.animal.birthDate = _birthDate;
        widget.animal.earringNumber = _earringNumber;
        widget.animal.animalRaceId = _selectedRace?.id;
        widget.animal.animalTypeId = _selectedType?.id;
        widget.animal.animalGender =
        _selectedGender == 'Erkek' ? AnimalGender.Masculine : AnimalGender.Feminine;
        widget.animal.animalGender = _selectedGender;

        Response response = await dio.put(
        'Animal/UpdateAnimalInfo?updateUserId',
        queryParameters: {
          "updateUserId": cachemanager.getItem(0)!.id!
        },
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
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Değişiklikleri kaydederken hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildTypeList() {
    String initialType = _selectedType != null ? _selectedType!.description ?? '' : ''; // Önceden seçilen türü alın

    return ListTile(
      title: Text('$initialType'),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              itemCount: animalType.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(animalType[index].description ?? ''),
                  onTap: () {
                    setState(() {
                      _selectedType = animalType[index];
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

  Widget _buildRaceList() {
    if (_selectedRace == null) {
      return ListTile(
        title: const Text('Irk Seçiniz'),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ListView.builder(
                itemCount: animalRace.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(animalRace[index].raceName ?? ''),
                    onTap: () {
                      setState(() {
                        _selectedRace = animalRace[index];
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
    } else {
      String initialRace = _selectedRace!.raceName ?? ''; // Önceden seçilen ırkı alın
      return ListTile(
        title: Text('$initialRace'), // Önceden seçilen ırkı göster
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ListView.builder(
                itemCount: animalRace.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(animalRace[index].raceName ?? ''),
                    onTap: () {
                      setState(() {
                        _selectedRace = animalRace[index];
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


  Widget _buildGenderList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cinsiyet'),
        Row(
          children: [
            Radio<AnimalGender>(
              value: AnimalGender.Masculine,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const Text('Erkek'),
            Radio<AnimalGender>(
              value: AnimalGender.Feminine,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const Text('Dişi'),
          ],
        ),
      ],
    );
  }

// API'den hayvan türlerini çeken metod
  Future<void> _fetchAnimalTypes() async {
    try {
      Response response = await dio.get(
        'AnimalType/GetAllAnimalTypes',
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data; // API'den gelen veri listesi
        setState(() {
          animalType = responseData.map((json) => AnimalTypeModel.fromJson(json))
              .toList();
        });
      } else {
        throw Exception("Http hatası");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//API'den hayvan ırklarını çeken metod
  Future<void> _fetchAnimalRaces() async {
    try {
      Response response = await dio.get(
        'AnimalRace/GetAllAnimalRaces',
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data; // API'den gelen veri listesi
        setState(() {
          animalRace = responseData.map((json) => AnimalRaceModel.fromJson(json))
              .toList();
        });
      } else {
        throw Exception("Http hatası");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}