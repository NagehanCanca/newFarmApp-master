import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../service/base.service.dart';

class EndTreatmentPage extends StatefulWidget {
  @override
  _EndTreatmentPageState createState() => _EndTreatmentPageState();
}

class _EndTreatmentPageState extends State<EndTreatmentPage> {
  late List<String> treatmentTypes = ['Cured', 'ToFollow', 'Ex'];
  String selectedTreatmentType = 'Cured';

  void _endTreatment() async {
    try {
      Response response = await dio.post(
        'Treatment/EndTreatment',
      );

      if (response.statusCode == HttpStatus.ok) {
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
        title: Text('End Treatment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Treatment Type:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
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
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _endTreatment,
              child: Text('End Treatment'),
            ),
          ],
        ),
      ),
    );
  }
}
