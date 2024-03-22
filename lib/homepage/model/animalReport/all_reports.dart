import 'dart:io';

import 'package:farmsoftnew/service/base.service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../model/animal_report_model.dart';

class NotificationListPage extends StatefulWidget {
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  List<AnimalReportModel> _notifications = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await dio.get(
        "AnimalReport/GetAllAnimalReports",
      );

      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İhbarlar listelendi.'),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() {
          // Durum güncellenebilir
          _notifications = (response.data as List)
              .map((item) => AnimalReportModel.fromJson(item))
              .toList();
        });
      } else {
        throw Exception('HTTP Hatası ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data.toString()),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Veri alımı tamamlandığında yükleniyor göstergesini gizle
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İhbar Listesi'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchNotifications, // Yenileme butonuna basıldığında verileri tekrar çek
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _notifications.isNotEmpty
          ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'Hayvan ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'İhbar Durumu',
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
                'Açıklama',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Kabul Kullanıcı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Kabul Tarihi',
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
                'RFID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Cinsiyet',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Bina',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Bölüm',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Padok',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _notifications
              .map(
                (report) => DataRow(
              cells: [
                DataCell(Text('${report.animalId}')),
                DataCell(Text('${report.animalReportStatus.toString().split('.').last}')),
                DataCell(Text('${_formatDate(report.date)}')),
                DataCell(Text('${report.description}')),
                DataCell(Text('${report.acceptUser}')),
                DataCell(Text('${_formatDate(report.acceptDate)}')),
                DataCell(Text('${report.earringNumber}')),
                DataCell(Text('${report.rfId}')),
                DataCell(Text('${report.animalGender.toString().split('.').last}')),
                DataCell(Text('${report.buildDescription}')),
                DataCell(Text('${report.sectionDescription}')),
                DataCell(Text('${report.paddockDescription}')),
              ],
            ),
          )
              .toList(),
        ),
      )
          : Center(
        child: Text('Gösterilecek veri bulunamadı.'),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
    } else {
      return "Tarih bilgisi yok";
    }
  }
}
