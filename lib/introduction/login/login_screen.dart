import 'dart:io';
import 'package:dio/dio.dart';
import 'package:farmsoftnew/homepage/model/animal/animal_test.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/base_cache_manager.dart';
import '../../model/user_model.dart';
import '../../screens/navigationhome/navigation_home_screen.dart';
import '../../service/base.service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  void _openBoxes() async {
    await Hive.openBox('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/LoyaLogoTp.png',
                    width: 300,
                    height: 255,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      Response response = await dio.get(
                        "User",
                        queryParameters: {
                          "username": usernameController.text,
                          "password": passwordController.text,
                        },
                      );
                      if (response.statusCode == HttpStatus.ok) {
                        UserModel user = UserModel();
                        user = UserModel.fromJson(response.data);
                        cachemanager.saveItem(user);
                        print("${cachemanager.getItem(0)?.firstName} ${cachemanager.getItem(0)?.lastName}");
                        //print(cachemanager.getItem(0)?.email);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimalTestScreen(),
                          ),
                        );
                      } else {
                        // Handle error
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Giriş'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
