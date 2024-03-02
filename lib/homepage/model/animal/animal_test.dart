import 'dart:io';
import 'package:farmsoftnew/homepage/model/animal/sidebar_menu.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../model/animal_model.dart';
import '../../../service/base.service.dart';

import '../../settings_screen.dart';
import 'animal_card_test.dart';


class AnimalTestScreen extends StatefulWidget {
  @override
  _AnimalTestScreenState createState() => _AnimalTestScreenState();
}

class _AnimalTestScreenState extends State<AnimalTestScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController earingNumberController = TextEditingController();
  String animalRfid = "";
  int _selectedIndex = 0;
  //List<AnimalTypeModel> animalType = [];

  final List<Widget> _pages = [
    AnimalTestScreen(), // Anasayfa
    SettingsPage(),     // Ayarlar
  ];

  Future<void> fetchAnimalRfid() async {
    try {
      String searchText = searchController.text;
      String RfId;
      String earingNumber;

      // RFID ve hayvan türünü ayır
      List<String> searchParts = searchText.split(" ");
      if (searchParts.length == 2) {
        RfId = searchParts[0];
        earingNumber = searchParts[1];
      } else if (searchParts.length == 1) {
        // Eğer sadece bir giriş varsa, bu sadece RFID olabilir
        RfId = searchText;
      } else {
        // Hatalı giriş durumu
        setState(() {
          animalRfid = "Geçersiz giriş";
          return;
        });
      }

      Response response = await dio.get(
        "Animal/GetAnimalByRfId",
        queryParameters: {
          "RfId": searchController.text,
          "earingNumber":  earingNumberController.text,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.data != null) {
          AnimalModel animal = AnimalModel.fromJson(response.data);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimalCard(
                animal: animal, animalType: [], animalRace: []),
            ),
          );
        } else {
          setState(() {
            animalRfid = "Bulunmuyor";
          });
        }
      }
    } catch (e, stackTrace) {
      print('Hata: $e, $stackTrace');
      setState(() {
        animalRfid = "Bir hata oluştu";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
      ),
      drawer: AnimalTestMenu(
        onMenuItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            getAppBarUI(), // AppBar'ı ekledik
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      style: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Arama yap...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      onEditingComplete: () {},
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.grey),
                    onPressed: fetchAnimalRfid,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        // "Ayarlar" butonuna tıklandığında SettingsPage ekranını açar
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      }
    });
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'FarmSoft',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/LoyaLogoTp.png'),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}

