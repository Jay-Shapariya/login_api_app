import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_api_app/screen/custom_search.dart';

class DataInfo extends StatefulWidget {
  const DataInfo({Key? key}) : super(key: key);

  @override
  State<DataInfo> createState() => _DataInfoState();
}

class _DataInfoState extends State<DataInfo> {
  final url = Uri.parse('https://reqres.in/api/users?page=2');

  List<dynamic> userData = [];
  late CustomSearchDelegate _searchDelegate;

  Future<void> fetchData() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body)['data'];
        _searchDelegate = CustomSearchDelegate(userData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
          ),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Show Information",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: _searchDelegate);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(userData[index]['avatar']),
            ),
            title: Text(
              '${userData[index]['first_name']} ${userData[index]['last_name']}',
            ),
            subtitle: Text("Email: ${userData[index]['email']}"),
          );
        },
      ),
    );
  }
}
