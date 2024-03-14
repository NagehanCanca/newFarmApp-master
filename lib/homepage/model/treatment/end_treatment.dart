import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../model/treatment_model.dart';
import '../../../service/base.service.dart';

class EndTreatmentPage extends StatefulWidget {
  final TreatmentModel treatmentModel;
  EndTreatmentPage({required this.treatmentModel});

  @override
  _EndTreatmentPageState createState() => _EndTreatmentPageState();
}

class _EndTreatmentPageState extends State<EndTreatmentPage> {
  late List<String> treatmentTypes = ['Tedavi Edildi', 'Takibe Al', 'Öldü'];
  String selectedTreatmentType = 'Tedavi Edildi';

  String message = '';

  void _endTreatment() async {
    try {
      Response response = await dio.put(
        'Treatment/EndTreatment',
        data: {
          'endDate': DateTime.now().toString(),
          'endUserId': widget.treatmentModel.endUserId,
          'treatmentEndType': widget.treatmentModel.treatmentEndType.toString().split('.').last,
          'treatmentEndMessage': widget.treatmentModel.treatmentEndMessage,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        setState(() {
          message = 'Tedavi başarıyla sonlandırıldı';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tedavi başarıyla sonlandırıldı'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context); // Önceki sayfaya geri dön
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      setState(() {
        message = 'Tedavi sonlandırılırken bir hata oluştu';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tedavi sonlandırılırken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedavi Sonlandır'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedTreatmentType,
              items: treatmentTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTreatmentType = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Tedavi Sonucu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  message = value;
                });
              },
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Açıklama...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _endTreatment,
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}