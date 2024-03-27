import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../service/base.service.dart';

class ScaleDenemePage extends StatefulWidget {
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
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => _fetchScaleData(1));
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
        title: Text('Scale Test Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Weight Data:',
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Text(
                weightData,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
