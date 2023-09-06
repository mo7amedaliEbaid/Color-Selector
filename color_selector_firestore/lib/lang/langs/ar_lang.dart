// ignore_for_file: annotate_overrides

import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';

class Portuguese extends Language {
  String get code => 'ar';
  String get langName => 'Arabic';

  String get title => 'محدد الالوان';

  String get wheelPicker => 'عجلة';
  String get palettePicker => 'طبق';
  String get valuePicker => 'قيمة';
  String get namedPicker => 'أسم';
  String get imagePicker => 'صورة';

  String get red => 'اللون الاحمر (Red)';
  String get green => 'اللون الاخضر (Green)';
  String get blue => 'الازرق (Blue)';
  String get alpha => 'Alpha';

  String get hexCode => 'هكس كود';
  String get hex => 'هكس';
  String get cssHex => 'css كود';
  String get clear => 'امسح';
  String get hexCodeMustNotBeEmpty => 'هكس كود لا يجب ان يكون خالى';
  String get hexCodeLengthMustBeSix =>
      'هكس كود يجب ان يكون ستة عناصر';
  String get hexCodeLimitedChars =>
      '';
  String get hexCodeOpacity =>
      '';

  String get hue => '';
  String get saturation => '';
  String get lightness => '';
  String get value => '';

  String get opacity => '';

  String get localImage => '';
  String get networkImage => '';
  String get selectPhoto => '';

  String get favoriteColorsTitle => '';
  String get haventFavoritedAnyBefore =>
      '';
  String get haventFavoritedAnyAfter =>
      '';
  String get favorite => '';
  String get unfavorite => '';
  String get favorited => '';
  String get unfavorited => '';

  String get copyToClipboard => '';
  Widget copiedToClipboard(String text) {
    return RichText(
      text: TextSpan(text: '', children: [
        TextSpan(text: text, style: const TextStyle(color: Colors.blue)),
        const TextSpan(text: ''),
      ]),
    );
  }

  String supportedPlatforms(List<TargetPlatform> platforms) {
    String text = '';
    return text;
  }

  String get seeColorInfo => '';
  String get colorInfo => '';
  String colorWithOpacity(String name, int opacity) =>
      '$name  $opacity%';

  String get settings => '';
  String get user => '';
  String get app => '';
  String get initialColor => '';
  String get language => '';

  String get open => '';
  String get close => '';

  String get about => '';
  String get author => '';
  String get openSource => '';
  String get madeWithFlutter => '💙';

  String get theme => '';
  String get dark => '';
  String get light => '';
  String get system => '';

  String minHeight(int height) =>
      '$height ';

  String get update => '';
  String get initialColorUpdated => '';

  String get url => '';
  String get urlMustNotBeEmpty => '';
  String get search => '';

  String get redColor => '';
  String get pink => '';
  String get purple => '';
  String get deepPurple => '';
  String get indigo => '';
  String get blueColor => 'ازرق';
  String get lightBlue => 'ازرق فاتح';
  String get cyan => 'سماوى';
  String get teal => 'تيل';
  String get grey => 'رمادى';
  String get blueGrey => 'ازرق رمادى';
  String get greenColor => 'اخضر';
  String get lightGreen => 'اخضر فاتح';
  String get lime => 'ليمونى';
  String get yellow => 'اصفر';
  String get amber => 'عنبر';
  String get orange => 'برتقالى';
  String get deepOrange => 'برتقالى غامق';
  String get brown => 'بنى';
}
