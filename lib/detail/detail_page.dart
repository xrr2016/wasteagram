import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wasteagram',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 40.0),
            child: Text(
              DateTime.now().toString(),
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            width: double.infinity,
            height: 300,
            child: Image.network(
              'https://coldstone.fun/images/react-context-hooks/cover.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              '9 Items',
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Text('location'),
          ),
        ],
      ),
    );
  }
}
