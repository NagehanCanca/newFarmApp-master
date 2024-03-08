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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Toplu Aşılama işlemi için geçiş yap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalSearchWidget(operationType: 'Aşılama')),
                );
              },
              child: Text('Toplu Aşılama'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Toplu Transfer işlemi için geçiş yap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalSearchWidget(operationType: 'Transfer')),
                );
              },
              child: Text('Toplu Transfer'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Toplu Yem Dağıtımı işlemi için geçiş yap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalSearchWidget(operationType: 'Yem Dağıtımı')),
                );
              },
              child: Text('Toplu Yem Dağıtımı'),
            ),
            // Buraya istediğiniz diğer toplu işlemleri ekleyebilirsiniz
          ],
        ),
      ),
    );
  }
}
