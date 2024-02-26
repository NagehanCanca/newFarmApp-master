import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bildirimler',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: Text('Bildirimleri Aç/Kapat'),
              value: false, // Bildirimlerin açık mı kapalı mı olduğunu buradan kontrol edebilirsiniz
              onChanged: (bool value) {
                // Bildirimlerin durumunu değiştirmek için burayı kullanabilirsiniz
              },
            ),
            SizedBox(height: 20),
            const Text(
              'Dil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Türkçe'),
              onTap: () {
                // Dil seçeneklerini buradan değiştirebilirsiniz
              },
            ),
            ListTile(
              title: Text('English'),
              onTap: () {
                // Dil seçeneklerini buradan değiştirebilirsiniz
              },
            ),
            SizedBox(height: 20),
            const Text(
              'Diğer Ayarlar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Hesap Ayarları'),
              onTap: () {
                // Hesap ayarları sayfasına gitmek için buradan yönlendirebilirsiniz
              },
            ),
            ListTile(
              title: Text('Uygulama Hakkında'),
              onTap: () {
                // Uygulama hakkında bilgiler sayfasına gitmek için buradan yönlendirebilirsiniz
              },
            ),
          ],
        ),
      ),
    );
  }
}
