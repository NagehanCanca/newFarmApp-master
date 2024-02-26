import 'package:dio/dio.dart';
import 'package:farmsoftnew/screens/change_password.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../service/base.service.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Sayfası'),
      ),
      body: FutureBuilder<UserModel>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            user = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First Name: ${user!.firstName}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Last Name: ${user!.lastName}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Email: ${user!.email}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                    },
                    child: const Text('Change Password'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<UserModel> getUserData() async {
    try {
      Response response = await dio.get("User");
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
