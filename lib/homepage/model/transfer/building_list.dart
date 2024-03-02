import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/transfer/section_list.dart';
import 'package:farmsoftnew/model/animal_model.dart';
import 'package:farmsoftnew/model/building_model.dart';
import 'package:flutter/material.dart';

import '../../../service/base.service.dart';

class BuildingList extends StatefulWidget {
  final AnimalModel animal;

  const BuildingList({super.key, required this.animal});

  @override
  _BuildingListState createState() => _BuildingListState();
}

class _BuildingListState extends State<BuildingList> {
  late List<BuildingModel> buildings;

  @override
  void initState() {
    super.initState();
    buildings = []; // Başlangıçta boş liste ile başlayalım
    _fetchBuildings(); // Binaları getiren metodu çağıralım
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binalar'),
      ),
      body: ListView.builder(
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(buildings[index].description ?? ''),
            subtitle: Text(buildings[index].code ?? ''),
            onTap: () {
              // Tıklanan binanın detay sayfasına gitmek için navigator kullanabilirsiniz
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionList(buildingId: buildings[index].id!, animal: widget.animal),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _fetchBuildings() async {
    try {
      Response response = await dio.get("Building");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response
            .data; // API'den gelen veri listesi
        setState(() {
          buildings =
              responseData.map((json) => BuildingModel.fromJson(json)).toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Binalar getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}