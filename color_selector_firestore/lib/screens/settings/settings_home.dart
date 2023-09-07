import 'dart:developer';

import 'package:color_picker/widgets/min_height.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

import '../../lang/lang.dart';
import '../../widgets/dialogs.dart';
import '../../providers/theme_provider.dart';

import 'settings_tile.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Language.of(context);
    final theme = ThemeProvider.of(context, false);
    return MinHeight(
      minScreenHeight: 300,
      child: ListView(
        padding: const EdgeInsets.only(left: 25, top: 75),
        children: <Widget>[
          Text(
            lang.settings,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          SettingsTitleTile(title: lang.user),
          SettingsTile(
            icon: Icons.format_color_fill,
            title: lang.initialColor,
            subColor: true,
            onTap: () {
              log("initial color pressed");
              showDialog(
                context: context,
                builder: (context) => const InitialColorDialog(),
              );
            },
          ),
          const Divider(),
          SettingsTitleTile(title: lang.app),
          SettingsTile(
            icon: Icons.language,
            title: lang.language,
            subtitle: lang.langName,
            onTap: () => showDialog(
              context: context,
              builder: (context) => const LanguageDialog(),
            ),
          ),
          SettingsTile(
            icon: ThemeDialog.getIconData(theme.mode),
            title: lang.theme,
            subtitle: lang.fromThemeMode(theme.mode),
            onTap: () => showDialog(
              context: context,
              builder: (_) => const ThemeDialog(),
            ),
          ),
          SettingsTile(
            icon: Icons.person,
            title: 'Profile',
            onTap: () => showDialog(
              context: context,
              builder: (_) => const ProfileDialog(),
            ),
          ),
          const Divider(),
          SettingsTitleTile(title: lang.about),
          Link(
            uri: Uri.parse('https://github.com/mo7amedaliEbaid'),
            builder: (context, followLink) => SettingsTile(
              icon: FontAwesomeIcons.at,
              title: "Developer",
              subtitle: 'Mohamed Ali',
              onTap: followLink,
            ),
          ),
          const Divider(),
          Link(
            uri: Uri.parse('https://github.com/mo7amedaliEbaid/Color-Selector'),
            builder: (context, followLink) => SettingsTile(
              icon: FontAwesomeIcons.at,
              title: "Source Code",
              subtitle: 'Github Repo',
              onTap: followLink,
            ),
          ),
          const Divider(),
            SizedBox(height: 10,),
            Align(
             alignment: Alignment.center,
             child: Container(
               height: 250,
               child: Column(
                 children: [
                   Image.asset("assets/logo.png",fit: BoxFit.contain,height: 180,),
                   SizedBox(height: 10,),
                   Text("Color Selector",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),)
                 ],
               ),
             ),
           )
        ],
      ),
    );
  }


}
