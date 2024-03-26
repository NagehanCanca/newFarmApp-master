import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/blend/blend.dart';
import 'package:flutter/material.dart';
import '../../../model/bait_distrubition_model.dart';
import '../../../model/base_cache_manager.dart';
import '../../../model/scale_device_model.dart';
import '../../../service/base.service.dart';

class ScaleDevicePage extends StatefulWidget {
  final int baitListid;
  const ScaleDevicePage({super.key, required this.baitListid});

  @override
  State<ScaleDevicePage> createState() => _ScaleDevicePageState();
}

class _ScaleDevicePageState extends State<ScaleDevicePage> {
  List<ScaleDeviceModel> deviceList = [];

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cihaz Seçimi'),
        actions: [],
      ),
      body: _buildDeviceList(),
    );
  }

  Widget _buildDeviceList() {
    return ListView.builder(
      itemCount: deviceList.length,
      itemBuilder: (context, index) {
        final device = deviceList[index];
        return InkWell(
          onTap: () {
            deviceList[index].scaleStatus == ScaleStatus.Ready ?
            _addBaitDistribution(deviceList[index].id!) :
            MaterialPageRoute(
                builder: (context) => BlendPage(BaitDistributionId : deviceList[0].baitDistrubitonId!)
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.grey, width: 1),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.devices, size: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Device Name: ${device.name}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('ID: ${device.id}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
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

  Future<void> _fetchDevices() async {
    try {
      Response response = await dio.get(
        "ScaleDevice/GetScaleDeviceByScaleType",
        queryParameters: {'scaleType': ScaleType.FeedMixingScale.index
        }
      );
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> responseData = response.data;
        setState(() {
          deviceList = responseData.map((json) => ScaleDeviceModel.fromJson(json)).toList();
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

    void _addBaitDistribution(int _deviceId) async {
    try {
      Response response = await dio.post(
        "BaitDistribution/AddBaitDistributionByBaitList",
        queryParameters: {
          'baitListId': widget.baitListid,
          'scaleDeviceId': _deviceId
        },
        data: cachemanager.getItem(0)?.toJson(),
      );
      if (response.statusCode == HttpStatus.ok) {
        dynamic responseData = response.data;

        BaitDistributionModel result = responseData.map((json) => BaitDistributionModel.fromJson(json));

        MaterialPageRoute(
          builder: (context) => BlendPage(BaitDistributionId : result.id!)
        );
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error blending baits'),
        ),
      );
    }
  }
}