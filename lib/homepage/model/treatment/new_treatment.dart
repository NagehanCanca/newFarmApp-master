import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';

class NewTreatmentPage extends StatefulWidget {
  final AnimalModel animal;

  const NewTreatmentPage({Key? key, required this.animal}) : super(key: key);

  @override
  _NewTreatmentPageState createState() => _NewTreatmentPageState();
}

class _NewTreatmentPageState extends State<NewTreatmentPage> {
  late TextEditingController _statusController;
  late TextEditingController _entryDateController;
  late TextEditingController _earringNumberController;
  late TextEditingController _corralNameController;
  late TextEditingController _treatmentStatusController;
  late TextEditingController _treatmentDateController;
  late TextEditingController _diagnosisController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController();
    _entryDateController = TextEditingController();
    _earringNumberController = TextEditingController(text: widget.animal.earringNumber);
    _corralNameController = TextEditingController();
    _treatmentStatusController = TextEditingController();
    _treatmentDateController = TextEditingController();
    _diagnosisController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Tedavi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hayvan Bilgileri',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildAnimalInfoFields(),
              SizedBox(height: 20),
              const Text(
                'Tedavi Bilgileri',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildTreatmentFields(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTreatment,
                child: Text('Tedaviyi Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimalInfoFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _statusController,
          decoration: InputDecoration(labelText: 'Durumu'),
        ),
        TextField(
          controller: _entryDateController,
          decoration: InputDecoration(labelText: 'Çiftliğe Giriş Tarihi'),
        ),
        TextField(
          controller: _earringNumberController,
          decoration: InputDecoration(labelText: 'Küpe No'),
          enabled: false,
        ),
        TextField(
          controller: _corralNameController,
          decoration: InputDecoration(labelText: 'Padok'),
        ),
      ],
    );
  }

  Widget _buildTreatmentFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _treatmentStatusController,
          decoration: InputDecoration(labelText: 'Tedavi Durumu'),
        ),
        TextField(
          controller: _treatmentDateController,
          decoration: InputDecoration(labelText: 'Tarih'),
        ),
        TextField(
          controller: _diagnosisController,
          decoration: InputDecoration(labelText: 'Tanı'),
        ),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Not'),
        ),
      ],
    );
  }

  void _submitTreatment() {
    // Burada form verileri gönderilebilir, API'ye kaydedilebilir veya başka işlemler yapılabilir.
    // Örneğin, bu verileri alıp yeni bir TreatmentModel oluşturabilir ve API'ye gönderebilirsiniz.
  }
}
