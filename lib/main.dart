import './app.dart';
import './exports.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await Hive.initFlutter();
    userService.init();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(App());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
