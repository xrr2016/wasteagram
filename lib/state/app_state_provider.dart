import '../exports.dart';

class AppStateProvider extends StatefulWidget {
  final Widget child;

  const AppStateProvider({required this.child});

  @override
  _AppStateProviderState createState() => _AppStateProviderState();
}

class _AppStateProviderState extends State<AppStateProvider> {
  late User? user = FirebaseAuth.instance.currentUser;
  int count = 0;

  setUser(User user) {
    setState(() {
      user = user;
    });
  }

  setCount(int count) {
    setState(() {
      count = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppState(count: count, user: user, child: widget.child);
  }
}
