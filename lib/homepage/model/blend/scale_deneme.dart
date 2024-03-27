import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../service/base.service.dart';

class ScaleDenemePage extends StatefulWidget {
  @override
  _ScaleDenemePageState createState() => _ScaleDenemePageState();
}

class _ScaleDenemePageState extends State<ScaleDenemePage> {
  final StreamController<int> _streamController = StreamController<int>();
  int? _currentScaleData;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      final response = await dio.get(
          "BaitDistributionProduct/Scale",
          options: Options(responseType: ResponseType.stream),
        onReceiveProgress:
      );
      if (response.statusCode == HttpStatus.ok) {
        final data =  response.data.stream;
        _streamController.add(data);
        setState(() {
          _currentScaleData = data;
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
        title: Text('Scale Data'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Text(
              'Current Scale Data: ${_currentScaleData ?? "Loading..."}',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Current Scale Data: ${snapshot.data}',
                    style: TextStyle(fontSize: 24),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
