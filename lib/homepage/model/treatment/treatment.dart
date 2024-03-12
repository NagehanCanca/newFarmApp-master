import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/treatment/edit_treatment.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/treatment_model.dart';
import '../../../service/base.service.dart';

class TreatmentPage extends StatefulWidget {
  final List<AnimalModel> selectedAnimals;

  const TreatmentPage({Key? key, required this.selectedAnimals}) : super(key: key);

  @override
  _TreatmentPageState createState() => _TreatmentPageState();
}

class _TreatmentPageState extends State<TreatmentPage> {
  late List<TreatmentModel> _treatments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTreatmentsForSelectedAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tedavi Bilgileri'),
      ),
      body: _isLoading
          ? _buildLoadingIndicator()
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildTreatmentTable(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(); // Bottom sheeti göster
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTreatmentTable() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Sıra No',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Tarih',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Tedavi Durumu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Küpe No',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Padok Adı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Tanı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Açıklama',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'İşlem',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: _treatments
          .map(
            (treatment) => DataRow(
          cells: <DataCell>[
            DataCell(Text(treatment.id.toString() ?? '')),
            DataCell(Text(_formatDate(treatment.date))),
            DataCell(Text(treatment.treatmentStatus.toString() ?? '')),
            DataCell(Text(treatment.animalEarringNumber ?? '')),
            DataCell(Text(treatment.paddockName ?? '')),
            DataCell(Text(treatment.diseaseDiagnoseId.toString() ?? '')),
            DataCell(Text(treatment.diseaseDiagnoseDescription ?? '')),
            DataCell(
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editTreatment(treatment); // Tedaviyi düzenle fonksiyonunu çağır
                },
              ),
            ),
          ],
        ),
      )
          .toList(),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  Future<void> _fetchTreatmentsForSelectedAnimals() async {
    try {
      Response response = await dio.get("Treatment/GetAllTreatmentAnimals");

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          _treatments = responseData
              .map((json) => TreatmentModel.fromJson(json))
              .toList();
          _isLoading = false; // Yükleme tamamlandı
        });
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching treatments: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tedavi bilgileri alınamadı'),
        ),
      );
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Tedavi Başlat'),
                onTap: () {
                  Navigator.pop(context); // Bottom sheeti kapat
                  _startTreatment(); // Tedavi başlat fonksiyonunu çağır
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Tedavi Düzenle'),
                onTap: () {
                  Navigator.pop(context); // Bottom sheeti kapat
                  // Düzenlemek için bir tedavi seçmelerini iste
                  if (_treatments.isNotEmpty) {
                    _selectAnimalAndEditTreatment();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Düzenlenecek tedavi bulunamadı'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _startTreatment() {
    // Tedavi başlatma işlemleri burada yapılacak
  }

  void _editTreatment(TreatmentModel treatment) {
    // Düzenlenecek tedavinin bilgileriyle EditTreatmentPage'e yönlendirme yap
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTreatmentPage(
          animal: AnimalModel(), // Burada bir hayvan modeli geçmeniz gerekecek
          treatment: treatment,
        ),
      ),
    );
  }

  void _selectAnimalAndEditTreatment() async {
    final selectedAnimal = await showDialog<AnimalModel>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hayvanı Seç'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lütfen tedaviyi düzenlemek istediğiniz hayvanı seçin:'),
              SizedBox(height: 20),
              DropdownButtonFormField<AnimalModel>(
                value: widget.selectedAnimals.isNotEmpty ? widget.selectedAnimals.first : null,
                onChanged: (selectedAnimal) {
                  Navigator.pop(context, selectedAnimal);
                },
                items: widget.selectedAnimals.map((animal) {
                  return DropdownMenuItem<AnimalModel>(
                    value: animal,
                    child: Text(animal.earringNumber ?? ""),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Hayvan',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialog'u kapat
              },
              child: Text('İptal'),
            ),
          ],
        );
      },
    );

    if (selectedAnimal != null) {
      // Seçilen hayvan varsa, tedaviyi düzenlemek için ilgili sayfayı aç
      _editTreatment(selectedAnimal as TreatmentModel);
    }
  }
}
