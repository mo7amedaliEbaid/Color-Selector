import 'package:color_picker/widgets/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:color/color.dart' hide Color;

import 'package:color_picker/widgets/opacity_slider.dart';

import '../../providers/theme_provider.dart';
import '../../clipboard.dart';
import '../../lang/lang.dart';

import '../../widgets/opacity_slider.dart';
import '../../widgets/color_preview.dart';

import '../../utils.dart';

part 'cielab_color_info.dart';
part 'hex_color_info.dart';
part 'hsl_color_info.dart';
part 'hsv_color_info.dart';
part 'rgb_color_info.dart';
part 'xyz_color_info.dart';

showColorInfoDialog(
  BuildContext context,
  String title,
  Color color,
) {
  final background = Theme.of(context).dialogBackgroundColor;
  showDialog(
    context: context,
    builder: (context) => Container(
      height: 200,
      width: 250,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        title: Center(child: Text(title)),
        contentPadding: const EdgeInsets.only(top: 20),
        content: Container(
          height: 150,
          width: 200,
          child: ColorInfo(
            color: color,
            background: background,
            shrinkable: false,
          ),
        ),
      ),
    ),
  );
}

class ColorInfo extends StatefulWidget {
  const ColorInfo({
    Key? key,
    required this.color,
    this.initial = 0,
    this.clipBehavior = Clip.antiAlias,
    this.slider,
    this.background,
    this.shrinkable = true,
    this.leading,
    this.onExpand,
  }) : super(key: key);

  final Color? color;
  final Color? background;
  final int initial;
  final OpacitySlider? slider;
  final Clip clipBehavior;
  final bool shrinkable;
  final Widget? leading;

  final VoidCallback? onExpand;

  @override
  _ColorInfoState createState() => _ColorInfoState();
}

class _ColorInfoState extends State<ColorInfo> {
  bool shrinked = false;
  final controller = ControllableExpansionTileController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.vertical(top: Radius.circular(25));
    final lang = Language.of(context);
    Widget w = Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      LimitedBox(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: 92.0,
        child: DefaultTextStyle(
          style: TextStyle(
            color: ThemeProvider.isBright(context) ? Colors.black : Colors.white,
          ),
          child: TabBarView(
            children: <Widget>[
              RGBColorInfo(color: widget.color),
              HEXColorInfo(color: widget.color),
              HSLColorInfo(color: widget.color),
              HSVColorInfo(color: widget.color),
              XYZColorInfo(color: widget.color),
              CielabColorInfo(color: widget.color),
            ].map<Widget>((child) {
              return Padding(padding: const EdgeInsets.all(8), child: child);
            }).toList(),
          ),
        ),
      ),
      if (widget.slider != null) widget.slider!,
    ]);
    TabBar tabBar = TabBar(
      isScrollable: true,
      labelColor: ThemeProvider.isBright(context) ? Colors.black : Colors.white,
      tabs: const <Widget>[
        Tab(text: 'RGB'),
        Tab(text: 'HEX'),
        Tab(text: 'HSL'),
        Tab(text: 'HSV'),
        Tab(text: 'XYZ'),
        Tab(text: 'Lab'),
      ],
    );
    if (widget.shrinkable) {
      w = DefaultTabController(
        length: 6,
        initialIndex: widget.initial,
        child: ControllableExpansionTile(
          radius: radius,
          initiallyExpanded: true,
          backgroundColor: Colors.transparent,
          title: SizedBox(
            height: 46,
            child: Row(children: [
              widget.leading ?? const SizedBox(),
              Expanded(child: tabBar),
            ]),
          ),
          trailing: buildCompactIconButton(
            icon: const Icon(Icons.expand_less),
            tooltip: shrinked ? lang.open : lang.close,
            onPressed: () {
              (shrinked ? controller.open : controller.close)();
            },
          ),
          children: [w],
          controller: controller,
          onExpansionChanged: (e) {
            setState(() => shrinked = !e);
            widget.onExpand?.call();
          },
        ),
      );
    } else {
      w = DefaultTabController(
        length: 6,
        initialIndex: widget.initial,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 46,
            child: ListTile(
              title: Row(children: [
                if (widget.leading != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: widget.leading,
                  ),
                Expanded(child: tabBar),
              ]),
            ),
          ),
          w,
        ]),
      );
    }
    w = Material(
      borderRadius: radius,
      elevation: 8,
      color: widget.background ??
          (ThemeProvider.isBright(context)
              ? Colors.grey[200]
              : Colors.grey[900]),
      child: w,
    );
    return w;
  }
}

class ColorName extends StatelessWidget {
  const ColorName({
    Key? key,
    required this.text,
    required this.value,
    required this.color,
  }) : super(key: key);

  final String text;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        children: [TextSpan(text: value, style: TextStyle(color: color))],
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}

Future showCopiedToClipboard(BuildContext context, String text) async {
  final lang = Language.of(context);
  await FlutterClipboard.copy(text);
  final content = lang.copiedToClipboard(text);
  if (ScaffoldMessenger.maybeOf(context) != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: content,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ));
  } else {
    showToast(
      // interactive: true,
      padding: EdgeInsets.zero,
      alignment: const Alignment(0, 1),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 200),
      animationBuilder: (context, animation, child) {
        return SlideTransition(
          child: child,
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation),
        );
      },
      child: Dismissible(
        key: ValueKey<String>(text),
        direction: DismissDirection.down,
        child: Material(
          elevation: 8,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: content,
          ),
        ),
      ),
      context: context,
    );
  }
}
