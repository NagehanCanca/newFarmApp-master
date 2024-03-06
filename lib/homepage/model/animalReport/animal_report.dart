import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/animal_report_model.dart';
import '../../../service/base.service.dart';

class AnimalReportPage extends StatefulWidget {
  final AnimalModel animal;

  const AnimalReportPage({super.key, required this.animal});
  @override
  _AnimalReportPageState createState() => _AnimalReportPageState();
}

class _AnimalReportPageState extends State<AnimalReportPage> {
  TextEditingController descriptionController = TextEditingController();
  AnimalReportModel? report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hayvan İhbarnamesi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Açıklama:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Açıklama giriniz...',
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // İhbarı gönderme işlemi burada yapılacak
                  _sendReport();
                },
                child: Text('İhbarı Gönder'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendReport() async {
    try {
      report = AnimalReportModel(
      animalReportStatus: AnimalReportStatus.NewReport,
      description: descriptionController.text,
      animalId: widget.animal.id,
      date: DateTime.now(),
    );
      Response response = await dio.post("AnimalReport/AddAnimalReport",
          data: report?.toJson()
      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İhbar gönderildi'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          // Durum güncellenebilir
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    }on DioException catch (e)   {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data.toString()),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
