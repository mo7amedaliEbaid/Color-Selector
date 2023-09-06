import 'package:flutter/material.dart';

import 'selector/image_selector.dart';
import '../../widgets/min_height.dart';

class ImagePickerHome extends StatefulWidget {
  const ImagePickerHome({Key? key}) : super(key: key);

  @override
  _ImagePickerHomeState createState() => _ImagePickerHomeState();
}

class _ImagePickerHomeState extends State<ImagePickerHome>
    with AutomaticKeepAliveClientMixin {
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MinHeight(
      minScreenHeight: 440,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ImageSelector(),
     ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
