import './exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // FirebaseOptions firebaseOptions = const FirebaseOptions(
  //   apiKey: '',
  //   appId: '',
  //   projectId: '',
  //   messagingSenderId: '',
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Wasteagram'),
    );
  }
}
