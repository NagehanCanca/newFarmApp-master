import 'package:flutter/material.dart';

class WeighingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simülasyon amaçlı rastgele bir ağırlık oluşturuldu.
    final double weight = 500 + (200 * (DateTime.now().millisecondsSinceEpoch % 10) / 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tartım Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'İnek Tartılıyor...',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'İneğin Kilosu: ${weight.toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
