import '../exports.dart';
import './widgets/home_drawer.dart';
import './widgets/waste_item_widget.dart';

class HomePage extends StatefulWidget {
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

  _goAuthPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
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
      drawer: HomeDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Wasteagram',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _goAuthPage,
            icon: Icon(Icons.account_circle_outlined),
          )
        ],
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
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Friends',
          icon: Icon(Icons.grade_outlined),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _isPicking ? null : _pickImage,
        tooltip: 'Pick Images',
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
