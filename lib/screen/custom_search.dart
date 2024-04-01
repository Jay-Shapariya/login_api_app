import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> userData;

  CustomSearchDelegate(this.userData);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> suggestionList = userData
        .where((user) => '${user['first_name']} ${user['last_name']}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            '${suggestionList[index]['first_name']} ${suggestionList[index]['last_name']}',
          ),
          subtitle: Text("Email: ${suggestionList[index]['email']}"),
          onTap: () {
            close(context, '${suggestionList[index]['first_name']}');
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestionList = userData
        .where((user) => '${user['first_name']} ${user['last_name']}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            '${suggestionList[index]['first_name']} ${suggestionList[index]['last_name']}',
          ),
          onTap: () {
            close(context, '${suggestionList[index]['first_name']}');
          },
        );
      },
    );
  }
}
