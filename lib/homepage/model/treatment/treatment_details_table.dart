import 'package:flutter/material.dart';
import '../../../model/treatment_note_model.dart';
import '../../../model/treatment_product_model.dart';

class TreatmentDetailsTablePage extends StatefulWidget {
  final TreatmentNoteModel treatmentNote;
  final TreatmentProductModel treatmentProduct;

  const TreatmentDetailsTablePage({
    Key? key,
    required this.treatmentNote,
    required this.treatmentProduct,
  }) : super(key: key);

  @override
  _TreatmentDetailsTablePageState createState() => _TreatmentDetailsTablePageState();
}

class _TreatmentDetailsTablePageState extends State<TreatmentDetailsTablePage> {
  late TextEditingController _noteController;
  late TextEditingController _productDescriptionController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    _productDescriptionController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Treatment Note',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Treatment Product',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _productDescriptionController,
              decoration: InputDecoration(
                labelText: 'Product Description',
              ),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveNote();
                _saveProduct();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    // Save treatment note using _noteController.text
  }

  void _saveProduct() {
    // Save treatment product using _productDescriptionController.text and _quantityController.text
  }
}
