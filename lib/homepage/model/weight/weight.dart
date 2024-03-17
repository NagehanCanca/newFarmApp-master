import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/weight/edit_weight.dart';
import 'package:farmsoftnew/service/base.service.dart';
import 'package:flutter/material.dart';
import '../../../model/weight_model.dart';

class WeightListPage extends StatefulWidget {
  @override
  _WeightListPageState createState() => _WeightListPageState();
}

class _WeightListPageState extends State<WeightListPage> {
  List<WeightModel> weights = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeights();
  }

  Future<void> fetchWeights() async {
    try {
      Response response = await dio.get("api/Weight/GetAllWeights");
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          weights = responseData.map((json) => WeightModel.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        print("Tartı sonuçları bulunamadı: ${response.statusCode}");
      }
    } catch (e) {
      print("Error loading weights: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tartım Bilgileri'),
      ),
      body: _isLoading
          ? _buildLoadingIndicator()
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildWeightTable(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransferOptions(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildWeightTable() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tartım İşlemleri'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text(
                'Tarih',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Tartı Durumu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Bina/Bölüm/Padok',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Scale Device ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Scale Device Açıklaması',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: weights.map((weight) {
            return DataRow(cells: [
              DataCell(Text(weight.date.toString())),
              DataCell(Text(weight.weightStatus.toString())),
              DataCell(Text('${weight.paddockDescription}-${weight.sectionDescription}-${weight.buildingDescription}')),
              DataCell(Text(weight.scaleDeviceId.toString())),
              DataCell(Text(weight.scaleDeviceDescription)),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  void _showTransferOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Yeni Tartım'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToNewWeight('Yeni Tartım');
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Toplu Tartım'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToNewWeight('Toplu Tartım');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToNewWeight(String operationType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewWeightPage(operationType),
      ),
    );
  }
}
