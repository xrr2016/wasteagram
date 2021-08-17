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
  late File photo;

  void _submitPost() async {
    final UploadTask uploadResult = await _uploadFile();

    debugPrint('Uploaded photo: $uploadResult');
  }

  Future<UploadTask> _uploadFile() async {
    File file = photo;
    UploadTask uploadTask;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/some-image.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        'picked-file-path': file.path,
      },
    );

    uploadTask = ref.putFile(photo, metadata);

    return Future.value(uploadTask);
  }

  @override
  void initState() {
    photo = File(widget.photo!.path);
    super.initState();
  }

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
              photo,
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
