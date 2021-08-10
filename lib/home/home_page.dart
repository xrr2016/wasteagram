import 'package:wasteagram/post/post_page.dart';

import '../exports.dart';
import '../detail/detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _goDetailPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DetailPage()),
    );
  }

  _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    debugPrint("Images picked: $photo");

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostPage(
          photo: photo,
        ),
      ),
    );
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
            child: Container(
              color: Colors.amberAccent,
              child: ListView(
                padding: EdgeInsetsDirectional.all(10.0),
                children: [
                  Container(
                    color: Colors.amber,
                    child: ListTile(
                      onTap: _goDetailPage,
                      title: Text(
                        DateTime.now().toString(),
                      ),
                      trailing: FittedBox(
                        child: Text(
                          '3',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: _goDetailPage,
                    title: Text(
                      DateTime.now().toString(),
                    ),
                    trailing: FittedBox(
                      child: Text(
                        '8',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Images',
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
