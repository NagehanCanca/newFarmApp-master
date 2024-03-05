import 'package:flutter/material.dart';
import 'package:farmsoftnew/screens/weighing/weighing_confirmation_page.dart';
import 'animal_search.dart';
import 'animal_test.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/LoyaLogoTp.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Loya Yazılım',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Anasayfa'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimalTestScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Hayvan Arama'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimalSearchWidget()),
              );
            },
          ),
          ListTile(
            title: Text('Tartı'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeighingConfirmationPage()),
              );
            },
          ),
          // Diğer menü öğelerini buraya ekleyebilirsiniz
        ],
      ),
    );
  }
}
