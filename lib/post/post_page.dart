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
  TextEditingController _textEditingController = TextEditingController();

  final CollectionReference _wasteItemsRef = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<WasteItem>(
        fromFirestore: (snapshots, _) => WasteItem.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Future<void> _uploadFile() async {
    UploadTask task = storage.ref(fileName).putFile(photo);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadedProgress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });
    }, onError: (e) {
      if (e.code == 'canceled') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The task has been canceled'),
        ));
      }
      if (task.snapshot.state == TaskState.canceled) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The task has been canceled'),
        ));
      }
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

  _getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    List<Placemark> placemarks = await placemarkFromCoordinates(
        _locationData.latitude!, _locationData.longitude!);

    return placemarks.first;
  }

  _saveWasteItem() async {
    try {
      final String waste = _textEditingController.text;

      if (waste.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Plase enter waste number~'),
        ));
        return;
      }

      await _uploadFile();
      final String imageURL = await storage.ref(fileName).getDownloadURL();
      final location = await _getCurrentLocation();

      await _wasteItemsRef.add(
        WasteItem(
          photo: imageURL,
          location: '${location.country} ${location.name}',
          waste: int.parse(waste),
          date: Timestamp.now(),
        ),
      );
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
      ));
    } catch (e) {
      debugPrint(e.toString());
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
    int screenWidth = MediaQuery.of(context).size.width.toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Column(
        children: [
          // LinearProgressIndicator(value: _uploadedProgress),
          SizedBox(height: 30),
          TextField(),
          SizedBox(height: 30),
          Container(
            color: Colors.blue,
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 12.0,
              children: [
                Container(
                  width: 120.0,
                  height: 120.0,
                  // margin: EdgeInsets.only(right: 12.0, bottom: 12.0),
                  child: Image(
                    image: ResizeImage(
                      FileImage(photo),
                      width: screenWidth,
                      height: 500,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 120.0,
                  child: Image(
                    image: ResizeImage(
                      FileImage(photo),
                      width: screenWidth,
                      height: 500,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 120.0,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   margin: const EdgeInsets.only(top: 20.0),
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: TextField(
          //     controller: _textEditingController,
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.number,
          //     keyboardAppearance: Brightness.dark,
          //   ),
          // ),
          Spacer(),
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   height: 60.0,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       textStyle: const TextStyle(fontSize: 20),
          //     ),
          //     onPressed: _saveWasteItem,
          //     child: const Text('Submit'),
          //   ),
          // ),
          SizedBox(height: 88.0)
        ],
      ),
    );
  }
}
