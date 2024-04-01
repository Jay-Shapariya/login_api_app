import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_api_app/controller/database.dart';
import 'package:login_api_app/screen/data_info_screen.dart';

class LoginInfo extends StatelessWidget {
  const LoginInfo({super.key});

  Future<List<Map<String, dynamic>>> getUserData() async {
    DatabaseHelper helper = DatabaseHelper();
    final db = await helper.database;
    return await db.query('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue,
        title: Text(
          'User Info',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Map<String, dynamic>> userData = snapshot.data!;
            if (userData.isNotEmpty) {
              String userId = userData[0]['userid'];
              String password = userData[0]['password'];
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'User ID: $userId',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Password: $password',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue)),
                      onPressed: () {
                        Get.to(() => const DataInfo());
                      },
                      child: Text(
                        "Next",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No user data found'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
