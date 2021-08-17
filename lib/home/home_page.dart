import '../exports.dart';
import './widgets/waste_item_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPicking = false;
  late Stream<QuerySnapshot<WasteItem>> _wasteItems;

  final _wasteItemsRef = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<WasteItem>(
        fromFirestore: (snapshots, _) => WasteItem.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  _pickImage() async {
    if (_isPicking) {
      return;
    }

    setState(() {
      _isPicking = true;
    });
    final ImagePicker _picker = ImagePicker();

    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _isPicking = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostPage(
          photo: photo,
        ),
      ),
    );
  }

  _getAllPosts() async {
    try {
      final items = await _wasteItemsRef.get();

      for (final item in items.docs) {
        debugPrint(item.data().toJson().toString());
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    // _getAllPosts();
    setState(() {
      _wasteItems = _wasteItemsRef.snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot<WasteItem>>(
                stream: _wasteItems,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                    itemExtent: 80.0,
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return WasteItemWidget(
                        wasteItem: data.docs[index].data(),
                      );
                    },
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isPicking ? null : _pickImage,
        tooltip: 'Pick Images',
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
