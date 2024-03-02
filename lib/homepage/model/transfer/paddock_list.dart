import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/animal_model.dart';
import 'package:flutter/material.dart';

import '../../../model/base_cache_manager.dart';
import '../../../model/paddock_model.dart';
import '../../../service/base.service.dart';

class PaddockList extends StatefulWidget {
  final int sectionId; // Section ID'si ile ilgili olarak değiştirildi
  final AnimalModel animal;

  const PaddockList({Key? key, required this.sectionId, required this.animal}) : super(key: key);

  @override
  _PaddockListState createState() => _PaddockListState();
}

class _PaddockListState extends State<PaddockList> {
  late List<PaddockModel> paddocks;

  @override
  void initState() {
    super.initState();
    paddocks = []; // Başlangıçta boş liste ile başlayalım
    _fetchPaddocks(); // Paddock'leri getiren metodu çağıralım
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paddock Listesi'),
      ),
      body: ListView.builder(
        itemCount: paddocks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(paddocks[index].description ?? ''),
            subtitle: Text(paddocks[index].code ?? ''),
            onTap: () {
              _transferAnimalToPaddock(paddocks[index].id!);
            },
          );
        },
      ),
    );
  }

  Future<void> _fetchPaddocks() async {
    try {
      Response response = await dio.get("Paddock?sectionId=${widget.sectionId}");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data; // API'den gelen veri listesi
        setState(() {
          paddocks = responseData.map((json) => PaddockModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Paddock\'lar getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _transferAnimalToPaddock(int paddockId) async {
    try {
      Response response = await dio.put(
        "Animal/UpdateAnimalPaddockTransfer",
        queryParameters: {
          "updateUserId": cachemanager.getItem(0)?.id,
          "newPaddockId": paddockId,
        },data:widget.animal.toJson()
      );
      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hayvan başarıyla transfer edildi'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('Transfer işlemi başarısız oldu: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hayvan transfer edilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}