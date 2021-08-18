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
  late final File photo;
  late final fileName;

  double _uploadedProgress = 0.0;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference _wasteItemsRef = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<WasteItem>(
        fromFirestore: (snapshots, _) => WasteItem.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  void _submitPost() async {
    await _saveWasteItem();
  }

  Future<void> _uploadFile() async {
    UploadTask task = storage.ref(fileName).putFile(photo);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadedProgress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });
      print('Task state: ${snapshot.state}');
    }, onError: (e) {
      if (e.code == 'canceled') {
        print('The task has been canceled');
      }
      if (task.snapshot.state == TaskState.canceled) {
        print('The task has been canceled');
      }
      print(TaskState.error);
    });

    try {
      await task;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Upload complete.'),
      ));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
      ));
    }
  }

  _saveWasteItem() async {
    try {
      await _uploadFile();
      String imageURL = await storage.ref(fileName).getDownloadURL();

      await _wasteItemsRef.add(
        WasteItem(
          photo: imageURL,
          location: 'china',
          waste: 5,
          date: Timestamp.now(),
        ),
      );
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
    fileName = basename(widget.photo!.path);
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
          LinearProgressIndicator(value: _uploadedProgress),
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
