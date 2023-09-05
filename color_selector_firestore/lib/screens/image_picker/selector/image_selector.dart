import 'package:flutter/material.dart';

import '../../../lang/lang.dart';

import '../../../providers/theme_provider.dart';
import 'local_selector.dart';
import 'network_selector.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double tabBarSize = 46;
    final lang = Language.of(context);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          LimitedBox(
            maxHeight: tabBarSize,
            child: TabBar(
              isScrollable: false,
              tabs: <Widget>[
                Tab(text: lang.localImage),
                Tab(text: lang.networkImage),
              ],
              labelColor:
                  ThemeProvider.isBright(context) ? Colors.black : Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.blue.shade800),
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [LocalImageSelector(), NetworkImageSelector()],
              ),
            ),
          )
        ],
      ),
    );
  }
}

DecorationImage buildDecorationImage(BuildContext context) {
  return DecorationImage(
    image: const AssetImage('assets/checkerboard.png'),
    fit: BoxFit.fill,
    colorFilter: ThemeProvider.isBright(context)
        ? null
        : ColorFilter.mode(
            Colors.grey.shade700,
            BlendMode.modulate,
          ),
  );
}
