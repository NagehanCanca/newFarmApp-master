import 'package:farmsoftnew/homepage/model/animalReport/all_reports.dart';
import 'package:flutter/material.dart';
import 'package:farmsoftnew/screens/weighing/weighing_confirmation_page.dart';
import '../transfer/transfer_operations.dart';
import '../treatment/treatment.dart';
import 'animal_search.dart';
import 'animal_test.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Loya.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 8),
                Text(
                  'Loya Yazılım',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const ListTile(
            title: Text(
              'Genel İşlemler',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const Divider( // İşlemler ile diğer ListTile'ları ayırmak için çizgi ekledim
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/home.png'),
              radius: 18,
            ),
            title: const Text(
              'Anasayfa',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimalTestScreen()),
              );
            },
          ),
          SizedBox(height: 10),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/search.png'),
              radius: 18,
            ),
            title: const Text(
              'Hayvan Arama',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimalSearchWidget(operationType: '',)),
              );
            },
          ),
          SizedBox(height: 10),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/health.png'),
              radius: 18,
            ),
            title: const Text(
              'Tedavi',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TreatmentPage(selectedAnimals: [],)),
              );
            },
          ),
          SizedBox(height: 10), // Boşluk ekledik
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/scale.png'),
              radius: 18,
            ),
            title: const Text(
              'Tartı',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeighingConfirmationPage()),
              );
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/transfer.png'),
              radius: 18,
            ),
            title: const Text(
              'Transfer',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransferOperationsPage()),
              );
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/vaccines.png'),
              radius: 18,
            ),
            title: const Text(
              'Aşı',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeighingConfirmationPage()),
              );
            },
          ),
          SizedBox(height: 10), // Boşluk ekledik
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/report.png'),
              radius: 18,
            ),
            title: const Text(
              'İhbar',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationListPage()),
              );
            },
          ),
          SizedBox(height: 10), // Boşluk ekledik
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/list.png'),
              radius: 18,
            ),
            title: const Text(
              'Hayvan Listesi',
              style: TextStyle(
                color: Colors.blue, // Metin rengini mavi yapar
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeighingConfirmationPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
