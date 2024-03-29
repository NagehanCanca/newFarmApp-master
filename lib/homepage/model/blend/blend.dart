import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/blend/scale_deneme.dart';
import 'package:farmsoftnew/model/bait_distrubition_product_model.dart';
import 'package:flutter/material.dart';

import '../../../model/bait_distrubition_model.dart';
import '../../../service/base.service.dart';

class BlendPage extends StatefulWidget {
  final BaitDistributionModel BaitDistribution;
  const BlendPage({Key? key, required this.BaitDistribution}) : super(key: key);

  @override
  _BlendPageState createState() => _BlendPageState();
}

class _BlendPageState extends State<BlendPage> {
  List<BaitDistributionProductModel> productList = [];


  @override
  void initState() {
    super.initState();
    _baitDistributionProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harmanlama Sayfası'),
        actions: [],
      ),
      body: _buildBlendList(),
    );
  }
  Widget _buildBlendList() {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScaleDenemePage(product: product),
              ),
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
                  const Icon(Icons.track_changes_outlined, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Harman: ${product.productName}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Text('Ürün: ${product.appliedTotalQuantity}', style: const TextStyle(fontSize: 16)),
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


  Future<void> _baitDistributionProducts() async {
    try {
        Response response = await dio.get(
          "BaitDistributionProduct/GetAllBaitDistributionProductsByBaitDistributionId",
          queryParameters: {
            'baitDistributionId': widget.BaitDistribution.id,
          },
        );
        if (response.statusCode == HttpStatus.ok) {
          List<dynamic> responseData = response.data;
          setState(() {
            productList =
                responseData.map((json) => BaitDistributionProductModel.fromJson(json))
                    .toList();
          });
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
