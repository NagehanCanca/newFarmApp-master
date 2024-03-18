import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/treatment_note_model.dart';
import '../../../model/treatment_product_model.dart';
import '../../../service/base.service.dart';


class TreatmentDetailsTablePage extends StatefulWidget {
  @override
  _TreatmentDetailsTablePageState createState() => _TreatmentDetailsTablePageState();
}

class _TreatmentDetailsTablePageState extends State<TreatmentDetailsTablePage> {
  late List<String> _medicationOptions;
  late List<String> _units;
  late String _selectedMedication = '';
  late String _selectedUnit = '';
  late TextEditingController _quantityController;
  late TextEditingController _noteController;
  late List<TreatmentProductModel> _medications = [];
  late List<TreatmentNoteModel> _notes = [];

  @override
  void initState() {
    super.initState();
    _medicationOptions = [];
    _units = [];
    _selectedMedication = '';
    _selectedUnit = '';
    _quantityController = TextEditingController();
    _noteController = TextEditingController();
    _medications = [];
    _notes = [];

    _fetchMedicationOptions();
    _fetchUnits();
  }

  Future<void> _fetchMedicationOptions() async {
    try {
      Response response = await dio.get('Treatment/GetAllMedication');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        _medicationOptions = responseData.map<String>((json) => json.toString()).toList();
        setState(() {}); // State'i güncelle
      } else {
        throw Exception('Failed to load medication options');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchUnits() async {
    try {
      Response response = await dio.get('YourUnitsApiUrlHere');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        _units = responseData.map<String>((json) => json.toString()).toList();
        setState(() {}); // State'i güncelle
      } else {
        throw Exception('Failed to load units');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  Future<void> _addMedication() async {
    // Yeni ilaç ekle
    final newMedication = TreatmentProductModel(
      id: 0,
      treatmentId: 0, // Değiştir
      animalId: 0, // Değiştir
      productId: 0, // Değiştir
      productDescription: _selectedMedication,
      unitId: _units.indexOf(_selectedUnit) + 1,
      quantity: double.parse(_quantityController.text),
      insertUser: 0, // Değiştir
      insertUserDescription: '',
      insertDate: DateTime.now(),
      updateUser: 0, // Değiştir
      updateUserDescription: '',
    );

    // API'ye ekle
    final response = await http.post(
      Uri.parse('your_add_medication_api_url_here'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newMedication.toJson()),
    );

    if (response.statusCode == 201) {
      setState(() {
        _medications.add(newMedication);
        _selectedMedication = '';
        _selectedUnit = '';
        _quantityController.clear();
      });
    } else {
      throw Exception('Failed to add medication');
    }
  }

  Future<void> _deleteMedication(int index) async {
    final deletedMedication = _medications[index];

    // API'den sil
    final response = await http.delete(
      Uri.parse('your_delete_medication_api_url_here/${deletedMedication.id}'),
    );

    if (response.statusCode == 204) {
      setState(() {
        _medications.removeAt(index);
      });
    } else {
      throw Exception('Failed to delete medication');
    }
  }

  Future<void> _addNote() async {
    // Yeni not ekle
    final newNote = TreatmentNoteModel(
      id: 0,
      treatmentId: 0, // Değiştir
      date: DateTime.now(),
      notes: _noteController.text,
      insertUser: 0, // Değiştir
      insertUserDescription: '',
      insertDate: DateTime.now(),
      updateUser: 0, // Değiştir
      updateUserDescription: '',
    );

    // API'ye ekle
    final response = await http.post(
      Uri.parse('your_add_note_api_url_here'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newNote.toJson()),
    );

    if (response.statusCode == 201) {
      setState(() {
        _notes.add(newNote);
        _noteController.clear();
      });
    } else {
      throw Exception('Failed to add note');
    }
  }

  Future<void> _deleteNote() async {
    final deletedNote = _notes.first;

    // API'den sil
    final response = await http.delete(
      Uri.parse('your_delete_note_api_url_here/${deletedNote.id}'),
    );

    if (response.statusCode == 204) {
      setState(() {
        _notes.removeAt(0);
      });
    } else {
      throw Exception('Failed to delete note');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detaylar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMedication,
              items: _medicationOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedMedication = value ?? '';
                });
              },
              decoration: InputDecoration(
                labelText: 'İlaç',
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedUnit,
              items: _units.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedUnit = value ?? '';
                });
              },
              decoration: InputDecoration(
                labelText: 'Birim',
              ),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Miktar',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addMedication,
                  child: Text('Ekle'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _deleteMedication(0), // Değiştir
                  child: Text('Sil'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Kırmızı renk
                  ),
                ),
              ],
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Not',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addNote,
                  child: Text('Ekle'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _deleteNote,
                  child: Text('Sil'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Kırmızı renk
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _medications.length,
                itemBuilder: (context, index) {
                  final medication = _medications[index];
                  return ListTile(
                    title: Text(
                        '${medication.productDescription} - ${medication.quantity} ${_units[medication.unitId - 1]}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteMedication(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
