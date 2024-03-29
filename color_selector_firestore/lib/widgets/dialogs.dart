import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_picker/screens/authentication/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../lang/lang.dart';
import '../models/users.dart';
import '../providers/auth_provider.dart';
import 'button.dart';
import 'opacity_slider.dart';
import '../screens/color_info/color_info.dart';

import '../utils.dart';
import '../main.dart';
import '../providers/theme_provider.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({Key? key}) : super(key: key);

  static IconData getIconData(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return FontAwesomeIcons.moon;
      case ThemeMode.light:
        return FontAwesomeIcons.sun;
      case ThemeMode.system:
      default:
        return FontAwesomeIcons.circleNotch;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    final lang = Language.of(context);
    return  MediaQuery.sizeOf(context).height < 150
        ? SizedBox.shrink()
        :SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          lang.theme,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      children: List.generate(ThemeMode.values.length, (index) {
        final mode = ThemeMode.values[index];
        return CheckboxListTile(
          secondary: FaIcon(getIconData(mode)),
          value: theme.mode == mode,
          onChanged: (_) => theme.mode = mode,
          title: Text(lang.fromThemeMode(mode)),
        );
      }),
    );
  }
}

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({Key? key}) : super(key: key);

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  @override
  Widget build(BuildContext context) {
    Language lang = Language.of(context);
    Language.languages.sort((a, b) => a.code == lang.code ? 1 : -1);
    return  MediaQuery.sizeOf(context).height < 150
        ? SizedBox.shrink()
        :SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Center(
        child: Text(
          lang.language,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      children: List<Widget>.generate(Language.languages.length, (index) {
        Language l = Language.languages[index];
        return CheckboxListTile(
          value: Language.of(context).code == l.code,
          onChanged: (mode) async {
            //    await Language.set(context, l);
          },
          title: Text(l.langName),
        );
      }),
    );
  }
}

class InitialColorDialog extends StatelessWidget {
  const InitialColorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    return  MediaQuery.sizeOf(context).height < 150
        ? SizedBox.shrink()
        :SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text(lang.initialColor, textAlign: TextAlign.center),
      contentPadding: EdgeInsets.zero,
      children: const <Widget>[RGBIntialColorChanger()],
    );
  }
}

class RGBIntialColorChanger extends StatefulWidget {
  const RGBIntialColorChanger({Key? key}) : super(key: key);

  @override
  _RGBIntialColorChangerState createState() => _RGBIntialColorChangerState();
}

class _RGBIntialColorChangerState extends State<RGBIntialColorChanger>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;
  late int red, green, blue;

  Color color = initialColor;

  @override
  void initState() {
    super.initState();
    red = initialColor.red;
    green = initialColor.green;
    blue = initialColor.blue;
    opacity = initialColor.opacity;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Language lang = Language.of(context);
    return Container(
      height: 400,
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Field(
            value: red.toDouble(),
            onChanged: (value) => setState(() => red = value.toInt()),
            color: Colors.redAccent,
            label: lang.red,
          ),
          Field(
            value: green.toDouble(),
            onChanged: (value) => setState(() => green = value.toInt()),
            color: Colors.green,
            label: lang.green,
          ),
          Field(
            value: blue.toDouble(),
            onChanged: (value) => setState(() => blue = value.toInt()),
            color: Colors.blue,
            label: lang.blue,
          ),
          ColorInfo(
            background: Colors.transparent,
            shrinkable: false,
            color: Color.fromARGB(
              255,
              red,
              green,
              blue,
            ).withOpacity(opacity),
            slider: OpacitySlider(
              onChanged: (value) => setState(() => opacity = value),
              value: opacity,
            ),
          ),
          Button(
            color: Colors.green,
            splashColor: Colors.lightGreenAccent,
            text:
                Text(lang.update, style: const TextStyle(color: Colors.white)),
            shadowEnabled: false,
            radius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            onTap: () async {
              showTextToast(text: lang.initialColorUpdated, context: context);
              Navigator.pop(context);
              await preferences.setString(
                'initialColor',
                Color.fromARGB(
                  255,
                  red,
                  green,
                  blue,
                ).withOpacity(opacity).encoded,
              );
              AppBuilder.state.update();
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Field extends StatelessWidget {
  const Field({
    Key? key,
    required this.color,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final Color color;
  final String label;
  final double value;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Slider(
          value: value,
          onChanged: onChanged,
          max: 255,
          min: 0,
          label: label,
          activeColor: color,
          inactiveColor: color.withOpacity(0.2),
        ),
      ),
      Text(
        value.toInt().toString(),
        style: DefaultTextStyle.of(context).style,
      ),
      const SizedBox(width: 10),
    ]);
  }
}

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({Key? key}) : super(key: key);

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  addData() async {
    UserProvider userProviders =
        Provider.of<UserProvider>(context, listen: false);

    await userProviders.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails userDetails = Provider.of<UserProvider>(context).getUser;
    int idx = userDetails.dateCreated.indexOf(" ");
    List parts = [
      userDetails.dateCreated?.substring(0, idx).trim() ?? "",
      userDetails.dateCreated?.substring(idx + 1).trim() ?? ""
    ];
    String date = parts.first;
    String time = parts.last;
    log(parts.toString());
    return MediaQuery.sizeOf(context).height < 150
        ? SizedBox.shrink()
        : SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Center(
              child: Text(
                userDetails.userName ?? "",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            children: List<Widget>.generate(1, (index) {
              return Container(
                width: 300,
                height: 290,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/logo.png"))),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        onBackgroundImageError: (exception, stackTrace) {
                          log(exception.toString());
                        },
                        radius: 50,
                        backgroundImage: NetworkImage(
                          userDetails.imageURL ??
                              "https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg",
                        ),
                        foregroundImage: NetworkImage(userDetails.imageURL ??
                            "https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Joined at",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(date)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(time)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(userDetails.email ?? "mo7amedaliebaid@gmail.com")
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<UserProvider>(context, listen: false)
                            .signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => AuthenticationPage()),
                            (route) => false);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back_ios),
                            Text(
                              "Sign Out",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
  }
}
