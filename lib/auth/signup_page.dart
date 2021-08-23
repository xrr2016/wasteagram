import '../exports.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email = '';
  String _password = '';

  _showSnackBar(String text, {label = 'Done'}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: label,
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }

  _signup() async {
    if (_email.isEmpty) {
      _showSnackBar('Email is required');
      return;
    }

    if (_password.isEmpty) {
      _showSnackBar('Password is required');
      return;
    }

    try {
      await AuthService.instance.register(_email, _password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.code, label: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                onChanged: (val) {
                  _email = val;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                initialValue: _password,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_clock_outlined),
                ),
                onChanged: (val) {
                  _password = val;
                },
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton.icon(
                onPressed: _signup,
                icon: Icon(Icons.send_outlined),
                label: Text('Signup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
