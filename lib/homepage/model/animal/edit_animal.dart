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

  @override
  void initState() {
    super.initState();
    _selectedType = ['İnek', 'Düve', 'Damızlık', 'Sığır', ].contains(widget.animal.animalTypeDescription) ? widget.animal.animalTypeDescription! : 'İnek';
    _selectedGender = _formatGender(widget.animal.animalGender);
    _earringNumber = widget.animal.earringNumber ?? '';
    _birthDate = widget.animal.birthDate ?? DateTime.now();
    _paddockNumber = widget.animal.paddockId;
    _race = widget.animal.origin ?? '';
    _buildDescription = widget.animal.buildDescription ?? '';
    _rfid = widget.animal.rfid ?? '';
    _animalTypeId = widget.animal.animalTypeId;
  }

  Future<void> _saveChanges() async {
    try {
      await dio.put('animals/${widget.animal.id}', data: {
        'animalTypeDescription': _selectedType,
        'earringNumber': _earringNumber,
        'birthDate': _birthDate.toIso8601String(),
        'paddockId': _paddockNumber,
        'origin': _race,
        'buildDescription': _buildDescription,
        'rfid': _rfid,
        'animalTypeId' : _animalTypeId,
        // Diğer alanları da ekleyebilirsiniz
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Değişiklikler başarıyla kaydedildi'),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context); // Önceki sayfaya geri dön
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Değişiklikleri kaydederken hata oluştu'),
        duration: Duration(seconds: 2),
      ));
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
        //color: Colors.green,
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
                items: <String>['İnek', 'Düve', 'Damızlık', 'Sığır']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value, // Değerleri benzersiz yap
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
                  labelText: 'Irki',
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
      case AnimalGender.Male:
        return 'Erkek';
      case AnimalGender.Female:
        return 'Dişi';
      default:
        return '';
    }
  }
}
