import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/model/base_cache_manager.dart';
import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import '../../../model/animal_vaccination_model.dart';
import '../../../service/base.service.dart';

class AnimalVaccinationPage extends StatefulWidget {
  final AnimalModel animal;

  const AnimalVaccinationPage({Key? key, required this.animal}) : super(key: key);

  @override
  _AnimalVaccinationPageState createState() => _AnimalVaccinationPageState();
}

class _AnimalVaccinationPageState extends State<AnimalVaccinationPage> {
  List<AnimalVaccinationModel> _vaccinations = [];

  @override
  void initState() {
    super.initState();
    _fetchVaccinations(widget.animal.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aşılar'),
      ),
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Tüm Aşılar'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildVaccinationList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccinationList() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('İşlem')),
        DataColumn(label: Text('Uygulama Tarihi')),
        DataColumn(label: Text('Aşı')),
        DataColumn(label: Text('Miktar')),
        DataColumn(label: Text('Birim')),
        DataColumn(label: Text('Uygulayan Kullanıcı')),
        DataColumn(label: Text('Tarih')),
      ],
      rows: _vaccinations.map((vaccination) {
        bool isPastDate = vaccination.applicationDay!.isBefore(DateTime.now());
        bool isApplied = vaccination.animalVaccinationStatus == AnimalVaccinationStatus.Applied;

        return DataRow(
          cells: [
            DataCell(
              isApplied
                  ? ElevatedButton(
                onPressed: () => _applyVaccination(vaccination),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // İptal Et butonunun arka plan rengini kırmızı olarak ayarlar
                ),
                child: Text('İptal Et', style: TextStyle(color: Colors.white)), // İptal Et butonunun metninin rengini beyaz olarak ayarlar
              )
                  : ElevatedButton(
                onPressed: isPastDate ? () => _applyVaccination(vaccination) : null,
                child: Text('Aşı Uygula'),
              ),
            ),
            DataCell(Text(vaccination.applicationDay.toString())),
            DataCell(Text(vaccination.productDescription ?? '')),
            DataCell(Text(vaccination.quantity.toString())),
            DataCell(Text(vaccination.unitCode ?? '')),
            DataCell(Text(vaccination.insertUser ?? '')),
            DataCell(Text(vaccination.insertDate?.toString() ?? '')),
          ],
        );
      }).toList(),
    );
  }

  Future<void> _fetchVaccinations(int animalId) async {
    try {
      Response response = await dio.get(
        "Vaccination/GetAllAnimalVacinationsByAnimalId",
        queryParameters: {
          "animalId": animalId,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        _vaccinations = responseData.map((json) => AnimalVaccinationModel.fromJson(json)).toList();
        setState(() {});
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aşı bilgileri getirilirken bir hata oluştu'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _applyVaccination(AnimalVaccinationModel vaccination) async {
    try {
      setState(() {
        if (vaccination.animalVaccinationStatus == AnimalVaccinationStatus.Applied)
          vaccination.animalVaccinationStatus = AnimalVaccinationStatus.NotApplied;
        else
          vaccination.animalVaccinationStatus = AnimalVaccinationStatus.Applied;
      });

      Response response = await dio.put(
        "Vaccination/UpdateAnimalVaccinationSchedule",
        queryParameters: {
          "userId": cachemanager.getItem(0)?.id,
        },
        data: vaccination.toJson(),
      );

      if (response.statusCode == HttpStatus.ok) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aşı başarıyla uygulandı'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('HTTP Hatası ${response.statusMessage}');
      }
    }  on DioException catch (e)  {
      setState(() {
        if (vaccination.animalVaccinationStatus == AnimalVaccinationStatus.Applied)
          vaccination.animalVaccinationStatus = AnimalVaccinationStatus.NotApplied;
        else
          vaccination.animalVaccinationStatus = AnimalVaccinationStatus.Applied;
      });
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
