import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../lang/lang.dart';

import '../../color_info/color_info.dart';
import '../../../utils.dart';
import '../../../widgets/chessboard.dart';

import '../image_color_picker.dart';

class LocalImageSelector extends StatefulWidget {
  const LocalImageSelector({Key? key}) : super(key: key);

  @override
  _LocalImageSelectorState createState() => _LocalImageSelectorState();
}

class _LocalImageSelectorState extends State<LocalImageSelector>
    with AutomaticKeepAliveClientMixin {
  Color color = Colors.black;

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  Uint8List? _imageURL;

  selectedImage() async {
    Uint8List imageURL = await pickImage(
      ImageSource.gallery,
    );
    setState(() {
      _imageURL = imageURL;
    });
  }


  final pickerKey = GlobalKey<ColorPickerWidgetState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final lang = Language.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(children: [
              const RepaintBoundary(child: ChessBoard()),
              if (_imageURL != null)
                LayoutBuilder(builder: (context, c) {
                  return ConstrainedBox(
                    constraints: c,
                    child: ColorPickerWidget(
                      key: pickerKey,
                      onUpdate: (color) => setState(() => this.color = color),
                      image: Image.memory(
                        _imageURL!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                })
            ]),
          ),
        ),
        ColorInfo(
          shrinkable: false,
          color: color,
          onExpand: () {
            pickerKey.currentState?.loadSnapshotBytes();
            setState(() {});
          },
          leading: buildCompactIconButton(
            icon: const FaIcon(FontAwesomeIcons.image),
            tooltip: lang.selectPhoto,
            onPressed: selectedImage,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
