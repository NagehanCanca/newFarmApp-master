import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/transfer/paddock_list.dart';
import 'package:farmsoftnew/model/animal_model.dart';
import 'package:flutter/material.dart';

import '../../../model/section_model.dart';
import '../../../service/base.service.dart';

class SectionList extends StatefulWidget {
  final int buildingId;
  final AnimalModel animal;
  const SectionList({Key? key, required this.buildingId, required this.animal}) : super(key: key);

  @override
  _SectionListState createState() => _SectionListState();
}

class _SectionListState extends State<SectionList> {
  late List<SectionModel> sections = [];
 int? selectedId;

  @override
  void initState() {
    super.initState();

   _fetchSections(); // Bölümleri getiren metodu çağıralım

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedId.toString()??''),
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sections[index].description ?? ''),
            subtitle: Text(sections[index].code ?? ''),
            onTap: () {
              setState(() {
                selectedId =  sections[index].id;
              });

              // Tıklanan binanın detay sayfasına gitmek için navigator kullanabilirsiniz
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaddockList(sectionId: sections[index].id!, animal: widget.animal),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _fetchSections() async {
    try {
      Response response = await dio.get("Section?buildingId=${widget.buildingId}",
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response
            .data; // API'den gelen veri listesi
setState(() {
  sections =  responseData.map((json) => SectionModel.fromJson(json)).toList();
});

      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bölümler getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
