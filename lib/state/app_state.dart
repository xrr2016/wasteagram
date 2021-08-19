import '../exports.dart';

class AppState extends InheritedWidget {
  final User? user;
  final int count;

  const AppState({
    required this.count,
    required this.user,
    required Widget child,
  }) : super(child: child);

  static of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
    // return context.getElementForInheritedWidgetOfExactType<AppState>()!.widget;
  }

  @override
  bool updateShouldNotify(covariant AppState oldWidget) {
    return user != oldWidget.user;
  }
}
