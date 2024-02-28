import 'package:farmsoftnew/screens/weighing/weighing_page.dart';
import 'package:flutter/material.dart';

class WeighingConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İnek Tartımı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'İneği Tartıya Çıkarmak İstiyor musunuz?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeighingPage()),
                );
              },
              child: const Text('Tartıya Çıkar'),
            ),
          ],
        ),
      ),
    );
  }
}
