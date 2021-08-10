import 'dart:io';

import 'package:flutter/material.dart';

import '../exports.dart';

class PostPage extends StatefulWidget {
  final XFile? photo;

  const PostPage({
    required this.photo,
  });

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  void _submitPost() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300.0,
            child: Image.file(
              File(widget.photo!.path),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              keyboardAppearance: Brightness.dark,
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 60.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: _submitPost,
              child: const Text('Submit'),
            ),
          ),
          SizedBox(height: 88.0)
        ],
      ),
    );
  }
}
