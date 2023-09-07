import 'package:color_picker/widgets/min_height.dart';
import 'package:flutter/material.dart';

import '../../lang/lang.dart';
import '../../db/database_manager.dart';
import '../../utils.dart';
import 'favorite_tile.dart';


class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _favoritesKey = GlobalKey<AnimatedListState>();

    final lang = Language.of(context);
    return MinHeight(
      minScreenHeight: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 25, top: 75),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            const SizedBox(width: 7),
            Text(
              lang.favoriteColorsTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            const Icon(Icons.favorite, color: Colors.white),
          ]),
          Expanded(
            child: Stack(children: [
              AnimatedList(
                key: _favoritesKey,//GlobalKeys.favoritesKey,
             //   shrinkWrap: true,
               //  physics: NeverScrollableScrollPhysics(),
                initialItemCount: FavoriteColors.colors.length,
                itemBuilder: (context, index, animation) {
                  var color = FavoriteColors.colors[index];
                  bool isFavorite = FavoriteColors.hasColor(color);
                  return FavoriteColors.colors.length == 0
                      ? SizedBox.shrink()
                      : SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FavoriteListTile(
                            color: color,
                            isFavorite: isFavorite,
                            animation: animation,
                          ),
                        );
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: FavoriteColors.colors.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 42),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: lang.haventFavoritedAnyBefore,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            children: [
                              const WidgetSpan(
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(text: lang.haventFavoritedAnyAfter),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
