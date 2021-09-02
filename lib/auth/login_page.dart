import '../exports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  _login() async {
    if (_email.isEmpty) {
      _showSnackBar('Please enter email', label: 'OK');
      return;
    }

    if (_password.isEmpty) {
      _showSnackBar('Please enter password', label: 'OK');
      return;
    }

    try {
      await authService.signIn(_email, _password);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.code, label: 'OK');
    }
  }

  void _goToSignupPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: TextButton(
              onPressed: _goToSignupPage,
              child: Text(
                'New Account',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
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
                onPressed: _login,
                icon: Icon(Icons.send_outlined),
                label: Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
