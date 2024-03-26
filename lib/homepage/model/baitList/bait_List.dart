import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/scaledevice/all_scaledevices.dart';
import 'package:farmsoftnew/model/bait_list_model.dart';
import 'package:flutter/material.dart';
import '../../../service/base.service.dart';

class BaitListPage extends StatefulWidget {
  const BaitListPage({super.key,});

  @override
  State<BaitListPage> createState() => _BaitListPageState();
}

class _BaitListPageState extends State<BaitListPage> {
  List<BaitListModel> baitList = [];

  @override
  void initState() {
    super.initState();
    _fetchBaits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yem Listesi'),
        actions: [],
      ),
      body: _buildBaitList(),
    );
  }

  Widget _buildBaitList() {
    return ListView.builder(
      itemCount: baitList.length,
      itemBuilder: (context, index) {
        final bait = baitList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScaleDevicePage(baitListid: baitList[index].id!),
              ),
            );
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
                        Text('Açıklama: ${bait.description}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Hayvan Sayısı: ${bait.animalCount}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Uygulanan Hayvan Sayısı: ${bait.appliedAnimalCount.toString().split('.').last}', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Tarih: ${_formatDate(bait.date!)}', style: TextStyle(fontSize: 16)),
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

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  Future<void> _fetchBaits() async {
    try {
      Response response = await dio.get(
        "BaitList/GetAllBaitLists",
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          baitList = responseData.map((json) => BaitListModel.fromJson(json)).toList();
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
