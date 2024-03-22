import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../model/treatment_note_model.dart';
import '../../../model/treatment_product_model.dart';
import '../../../service/base.service.dart';

class NotesAndMedicationsPage extends StatefulWidget {
  const NotesAndMedicationsPage({Key? key}) : super(key: key);

  @override
  _NotesAndMedicationsState createState() => _NotesAndMedicationsState();
}

class _NotesAndMedicationsState extends State<NotesAndMedicationsPage> {
  List<TreatmentProductModel> medications = [];
  List<TreatmentNoteModel> notes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMedications();
    _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlaçlar ve Notlar'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İlaçlar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'İlaç Adı',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Miktar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Kaydeden Kullanıcı',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Kayıt Tarihi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: medications.map((medication) {
                return DataRow(
                  cells: [
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          // Navigate to medication details page
                        },
                        child: Text(medication.id.toString()),
                      ),
                    ),
                    DataCell(Text('${medication.quantity}')),
                    DataCell(Text(medication.updateUserDescription ?? '-')),
                    DataCell(Text(medication.updateDate?.toString() ?? '-')),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Notlar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Not İçeriği',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Kaydeden Kullanıcı',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Kayıt Tarihi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: notes.map((note) {
                return DataRow(
                  cells: [
                    DataCell(Text(note.notes)),
                    DataCell(Text(note.updateUserDescription ?? '-')),
                    DataCell(Text(note.updateDate?.toString() ?? '-')),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchMedications() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await dio.get(
        "TreatmentProduct/GetAllTreatmentProducts",
      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İlaçlar Listelendi.'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          medications = (response.data as List)
              .map((item) => TreatmentProductModel.fromJson(item))
              .toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data.toString()),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Veri alımı tamamlandığında yükleniyor göstergesini gizle
      });
    }
  }

  Future<void> _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await dio.get(
        "TreatmentNote/GetAllTreatmentNotes",
      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notlar Listelendi.'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          notes = (response.data as List)
              .map((item) => TreatmentNoteModel.fromJson(item))
              .toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data.toString()),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
