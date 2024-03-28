import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/treatment_model.dart';
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
  TreatmentNoteModel? treatmentNote;
  TreatmentModel? treatment;
  TreatmentProductModel? treatmentProduct = TreatmentProductModel();
  int? _noteId;
  int? _treatmentId;

  @override
  void initState() {
    super.initState();
    _fetchMedications();
    _fetchNotes();
    _noteId = treatmentNote?.id ?? 0;
    _treatmentId = treatment?.id;
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
            SizedBox(height: 10),
            Text(
              'İlaçlar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text('İşlem')),
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
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteMedication();
                        },
                      ),
                    ),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          // Navigate to medication details page
                        },
                        child: Text(medication.id.toString()),
                      ),
                    ),
                    DataCell(Text('${medication.quantity}')),
                    DataCell(
                        Text(medication.updateUserDescription ?? '-')),
                    DataCell(
                        Text(medication.updateDate?.toString() ?? '-')),
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
                DataColumn(label: Text('İşlem')),
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
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteNote();
                        },
                      ),
                    ),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          // Navigate to medication details page
                        },
                        child: Text(note.id.toString()),
                      ),
                    ),
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
        "TreatmentProduct/GetAllTreatmentProductsByTreatmentId",
        queryParameters: {
          'treatmentId' : _treatmentId
        }
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
        _isLoading =
            false;
      });
    }
  }

  Future<void> _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await dio.get(
        "TreatmentNote/GetAllTreatmentNotesByTreatmentId",
        queryParameters: {
          'treatmentId' : _treatmentId
        }
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
}
