part of 'database_manager.dart';

class FavoriteColors {
  static List<Color> colors = [];
  final _favoritesKey = GlobalKey<AnimatedListState>();

  static bool hasColor(Color color) {
    for (Color c in colors) {
      if (c.red == color.red &&
          c.green == color.green &&
          c.blue == color.blue &&
          c.alpha == color.alpha) {
        return true;
      }
    }
    return false;
  }
  Future<void> favorite(Color color) async {
    await DatabaseManager.favoritesBox.add({
      'alpha': color.alpha,
      'red': color.red,
      'green': color.green,
      'blue': color.blue,
    });

    FavoriteColors.colors.add(color);
   _favoritesKey.currentState?.insertItem(
      FavoriteColors.colors.indexOf(color),
      duration: itemSlideAnimationDuration,
    );
    // await Future.delayed(itemSlideAnimationDuration);
    // need to update the screen because the list if not the only thing that
    // show favorited colors
    AppBuilder.state.update();
  }

 static const itemSlideAnimationDuration = Duration(milliseconds: 400);

  Future<void> unfavorite(Color color) async {
    // await favoritesBox.clear();
    final valueInDb =  DatabaseManager.favoritesBox.values.firstWhere((element) {
      return element['alpha'] == color.alpha &&
          element['red'] == color.red &&
          element['green'] == color.green &&
          element['blue'] == color.blue;
    });
    await  DatabaseManager.favoritesBox.deleteAt( DatabaseManager.favoritesBox.values.toList().indexOf(valueInDb));

    int index = FavoriteColors.colors.indexOf(color);
    var c = FavoriteColors.colors[index];
    bool isFavorite = FavoriteColors.hasColor(color);
    _favoritesKey.currentState?.removeItem(
      index,
          (context, animation) => SlideTransition(
        child: FavoriteListTile(
          color: c,
          isFavorite: isFavorite,
          animation: animation,
        ),
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
      ),
      duration: itemSlideAnimationDuration,
    );
    // await Future.delayed(itemSlideAnimationDuration);
    FavoriteColors.colors.remove(color);
    AppBuilder.state.update();
  }

 static Future<List<Color>> favorites() async {
    final List? maps =  DatabaseManager.favoritesBox.values.toList();
    if (maps != null && maps.isNotEmpty) {
      FavoriteColors.colors = List.generate(maps.length, (i) {
        var map = maps[i];
        return Color.fromARGB(
            map['alpha'], map['red'], map['green'], map['blue']);
      });
    }
    return FavoriteColors.colors;
  }
}

/*Future<void> favorite(Color color) async {
  await favoritesBox.add({
    'alpha': color.alpha,
    'red': color.red,
    'green': color.green,
    'blue': color.blue,
  });

  FavoriteColors.colors.add(color);
  GlobalKeys.favoritesKey.currentState?.insertItem(
    FavoriteColors.colors.indexOf(color),
    duration: itemSlideAnimationDuration,
  );
  // await Future.delayed(itemSlideAnimationDuration);
  // need to update the screen because the list if not the only thing that
  // show favorited colors
  AppBuilder.state.update();
}

const itemSlideAnimationDuration = Duration(milliseconds: 400);

Future<void> unfavorite(Color color) async {
  // await favoritesBox.clear();
  final valueInDb = favoritesBox.values.firstWhere((element) {
    return element['alpha'] == color.alpha &&
        element['red'] == color.red &&
        element['green'] == color.green &&
        element['blue'] == color.blue;
  });
  await favoritesBox.deleteAt(favoritesBox.values.toList().indexOf(valueInDb));

  int index = FavoriteColors.colors.indexOf(color);
  var c = FavoriteColors.colors[index];
  bool isFavorite = FavoriteColors.hasColor(color);
  GlobalKeys.favoritesKey.currentState?.removeItem(
    index,
    (context, animation) => SlideTransition(
      child: FavoriteListTile(
        color: c,
        isFavorite: isFavorite,
        animation: animation,
      ),
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
    ),
    duration: itemSlideAnimationDuration,
  );
  // await Future.delayed(itemSlideAnimationDuration);
  FavoriteColors.colors.remove(color);
  AppBuilder.state.update();
}

Future<List<Color>> favorites() async {
  final List? maps = favoritesBox.values.toList();
  if (maps != null && maps.isNotEmpty) {
    FavoriteColors.colors = List.generate(maps.length, (i) {
      var map = maps[i];
      return Color.fromARGB(
          map['alpha'], map['red'], map['green'], map['blue']);
    });
  }
  return FavoriteColors.colors;
}*/
