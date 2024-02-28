import 'package:flutter/material.dart';
import '../../../screens/weighing/weighing_confirmation_page.dart';
import 'animal_test.dart';

class AnimalTestMenu extends StatefulWidget {
  final Function(int) onMenuItemSelected;

  const AnimalTestMenu({Key? key, required this.onMenuItemSelected}) : super(key: key);

  @override
  _AnimalTestMenuState createState() => _AnimalTestMenuState();
}

class _AnimalTestMenuState extends State<AnimalTestMenu> {
  int _selectedIndex = 0;

  final List<String> _menuItems = [
    'Anasayfa',
    'Tartı',
    'Tedavi',
    'Takip',
    'İstatistikler',
    'Padok',
    'Yem Karma',
    'Aşı',
    'Transfer İşlemleri',
  ];

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
          for (int index = 0; index < _menuItems.length; index++)
            ListTile(
              title: Text(_menuItems[index]),
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                // Hangi öğe seçilmişse ona göre sayfa açılır
                switch (_menuItems[index]) {
                  case 'Anasayfa':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnimalTestScreen()),
                    );
                    break;
                  case 'Tartı':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeighingConfirmationPage()),
                    );
                    break;
                  // case 'Tedavi':
                  //   Navigator.push(
                  //     context,
                  //    // MaterialPageRoute(builder: (context) => TreatmentScreen()),
                  //   );
                    break;
                // Diğer öğeler için gereken sayfaların açılması burada eklenir
                  default:
                    widget.onMenuItemSelected(index);
                }
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}