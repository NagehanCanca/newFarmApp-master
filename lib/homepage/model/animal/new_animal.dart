import 'package:flutter/material.dart';

class AddAnimalPage extends StatefulWidget {
  @override
  _AddAnimalPageState createState() => _AddAnimalPageState();
}

class _AddAnimalPageState extends State<AddAnimalPage> {
  String? _selectedType;
  String? _selectedGender;
  String? _earringNumber;
  DateTime? _birthDate;
  String? _paddockNumber;
  String? _race;

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hayvan Ekle'),
        backgroundColor: Colors.green, // AppBar rengi
      ),
      body: Padding(
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
                items: <String>['İnek', 'Dana', 'Koç', 'Koyun', 'Keçi']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Cinsiyet'),
              Row(
                children: [
                  Radio<String>(
                    value: 'Erkek',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const Text('Erkek'),
                  Radio<String>(
                    value: 'Dişi',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const Text('Dişi'),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Küpe No'),
              TextField(
                onChanged: (value) {
                  _earringNumber = value;
                },
              ),
              const SizedBox(height: 20),
              const Text('Doğum Tarihi'),
              ElevatedButton(
                onPressed: () async {
                  DateTime? selectedDate = await _selectDate(context);
                  if (selectedDate != null) {
                    setState(() {
                      _birthDate = selectedDate;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Buton rengi
                  onPrimary: Colors.white, // Buton metin rengi
                ),
                child: Text(_birthDate != null ? _birthDate!.toString() : 'Tarih Seç'),
              ),
              const SizedBox(height: 20),
              const Text('Padok No'),
              TextField(
                onChanged: (value) {
                  _paddockNumber = value;
                },
              ),
              const SizedBox(height: 20),
              const Text('Irki'),
              TextField(
                onChanged: (value) {
                  _race = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ekleme işlemi burada gerçekleştirilebilir
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Buton rengi
                  onPrimary: Colors.white, // Buton metin rengi
                ),
                child: const Text('Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
