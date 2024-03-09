import 'package:flutter/material.dart';
import '../animal/animal_search.dart';

class BulkOperationSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toplu İşlem Seçimi'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalSearchWidget(operationType: 'Aşılama')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Icon(Icons.medical_services),
              label: const Text('Toplu Aşılama', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalSearchWidget(operationType: 'Transfer')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Toplu Transfer', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalSearchWidget(operationType: 'Yem Dağıtımı')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Icon(Icons.fastfood),
              label: const Text('Toplu Yem Dağıtımı', style: TextStyle(fontSize: 18)),
            ),
            // Buraya istediğiniz diğer toplu işlemleri ekleyebilirsiniz
          ],
        ),
      ),
    );
  }
}
