import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/all_vaccination_model.dart';
import 'package:flutter/material.dart';
import '../../../service/base.service.dart';

class AllVaccinationPage extends StatefulWidget {
  const AllVaccinationPage({super.key});

  @override
  State<AllVaccinationPage> createState() => _AllVaccinationPageState();
}

class _AllVaccinationPageState extends State<AllVaccinationPage> {
  List<AllVaccinationModel> vaccinationList = [];
  AllVaccinationModel? vaccination = AllVaccinationModel();

  @override
  void initState() {
    super.initState();
    _fetchVacinations();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aşı Takvimi'),
        actions: [],
      ),
      body: _buildVaccinationList(),
    );
  }

  Widget _buildVaccinationList() {
    return ListView.builder(
      itemCount: vaccinationList.length,
      itemBuilder: (context, index) {
        final animal = vaccinationList[index];
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ScaleDevicePage(),
            //   ),
            // );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.pets, size: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ürün Barkodu: ${vaccination?.productBarcode}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Ürün Adı: ${vaccination?..productDescription}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Miktar: ${vaccination?.quantity}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Birim Kodu: ${vaccination?.unitCode.toString().split('.').last}', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Gün: ${_formatDate(vaccination?.day as DateTime?)}', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Kaydeden kullanıcı: ${vaccination?.updateUser}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Kayıt Tarihi: ${_formatDate(vaccination?.updateDate)}', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
    } else {
      return "";
    }
  }

  Future<void> _fetchVacinations() async {
    try {
      Response response = await dio.get(
        "Vaccination/GetVaccination",
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          vaccinationList = responseData.map((json) => AllVaccinationModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching animal list'),
        ),
      );
    }
  }
}
