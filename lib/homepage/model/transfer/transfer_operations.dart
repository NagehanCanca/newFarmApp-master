import 'package:farmsoftnew/homepage/model/transfer/transfer_animal_search.dart';
import 'package:flutter/material.dart';
import 'package:farmsoftnew/homepage/model/transfer/new_selection.dart';

class TransferOperationsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer İşlemleri'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Yeni transfer için TransferAnimalSearchWidget sayfasını açma
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransferAnimalSearchWidget()), // AnimalSearchWidget yerine TransferAnimalSearchWidget kullanıldı
                ).then((selectedAnimal) {
                  // Once an animal is selected, navigate to the next selection screen
                  if(selectedAnimal != null) {
                    // Navigate to the next selection screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextSelectionScreen(selectedAnimal: selectedAnimal, operationType: 'Yeni Transfer',)), // operationType düzeltilmeli
                    );
                  }
                });
              },
              child: const Text('Yeni Transfer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Toplu transfer için TransferAnimalSearchWidget sayfasını açma
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransferAnimalSearchWidget()), // AnimalSearchWidget yerine TransferAnimalSearchWidget kullanıldı
                ).then((selectedAnimal) {
                  // Once an animal is selected, navigate to the next selection screen
                  if(selectedAnimal != null) {
                    // Navigate to the next selection screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextSelectionScreen(selectedAnimal: selectedAnimal, operationType: 'Toplu Transfer',)), // operationType düzeltilmeli
                    );
                  }
                });
              },
              child: const Text('Toplu Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
