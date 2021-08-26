import '../exports.dart';

class UserService {
  static late Box box;
  static String name = 'USER_BOX';
  static String _uid = '';
  static User get currentUser => box.get(_uid);

  UserService() {
    init();
  }

  init() async {
    box = await Hive.openBox(name);
    debugPrint('UserService init');
  }

  save(User? user) async {
    await box.put(user!.uid, user);
    _uid = user.uid;
  }

  remove() async {
    await box.delete(_uid);
    _uid = '';
  }
}
