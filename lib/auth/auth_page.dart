import '../exports.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';

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
      body: Form(
        child: Column(
          children: [
            TextFormField(
              initialValue: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                // suffix: Text('suffix'),
                suffixText: '1111',
                suffixIcon: Icon(Icons.clear),
              ),
              onChanged: (val) {
                _email = val;
              },
            ),
            TextFormField(
              initialValue: _password,
              obscureText: true,
              keyboardType: TextInputType.text,
              onChanged: (val) {
                _password = val;
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                debugPrint(_email);
                debugPrint(_password);
              },
              icon: Icon(Icons.inbox),
              label: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
