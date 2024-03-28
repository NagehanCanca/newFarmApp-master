import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../model/bait_distrubition_product_model.dart';
import '../../../service/base.service.dart';

class ScaleDenemePage extends StatefulWidget {
  final BaitDistributionProductModel product;

  const ScaleDenemePage({Key? key, required this.product}) : super(key: key);

  @override
  _ScaleDenemePageState createState() => _ScaleDenemePageState();
}

class _ScaleDenemePageState extends State<ScaleDenemePage> {
  late String weightData;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    weightData = '';
    timer = Timer.periodic(
        const Duration(milliseconds: 500), (Timer t) => _fetchScaleData(1));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _fetchScaleData(int scaleId) async {
    try {
      Response response = await dio.get(
          'ScaleDevice/GetWeight',
          queryParameters: {"scaleId": scaleId}
      );
      if (response.statusCode == HttpStatus.ok) {
        setState(() {
          weightData = response.data.toString();
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Detayları: ${widget.product.productName}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Toplam Miktar: ${widget.product.totalQuantity}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tartı Ölçümü:',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      weightData,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Verileri kaydetme işlemi (örnek olarak bir mesaj yazdım)
              print('Veriler kaydedildi: $weightData');
              Navigator.pop(context);
            },
            child: Text('Onayla'),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}