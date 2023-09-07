part of 'main.dart';

class AppBuilder extends StatefulWidget {
  const AppBuilder({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  AppBuilderState createState() => AppBuilderState();

  static AppBuilderState get state => GlobalKeys.appBuilderKey.currentState!;
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(context) => widget.child;

  void update() => ThemeProvider.of(context, false).notify();
}
