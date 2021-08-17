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
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference _wasteItemsRef = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<WasteItem>(
        fromFirestore: (snapshots, _) => WasteItem.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  void _submitPost() async {
    await _uploadFile();
    // await _saveWasteItem();
  }

  Future<void> _uploadFile() async {
    // final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(photo.path);

    try {
      TaskSnapshot task = await storage.ref(fileName).putFile(photo);

      debugPrint((task.bytesTransferred / task.totalBytes).toString());
      debugPrint(task.ref.fullPath);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
      ));
    }
  }

  _saveWasteItem() async {
    try {
      await _uploadFile();
      // await _wasteItemsRef.add(
      //   WasteItem(
      //     photo: 'https://coldstone.fun/images/learn-ast/ast-cover.jpg',
      //     location: 'china',
      //     waste: 5,
      //     date: Timestamp.now(),
      //   ),
      // );
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
      ));
    }
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
