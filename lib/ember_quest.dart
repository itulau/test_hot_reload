import 'dart:async';
import 'dart:ui';

import 'package:ember_quest/actors/ember.dart';
import 'package:ember_quest/objects/star.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:watcher/watcher.dart';


class EmberQuestGame extends FlameGame {
  EmberQuestGame();

  late EmberPlayer _ember;
  late Star _star;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAll([
      "ember.png",
      "star.png",
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    _ember = EmberPlayer(position: Vector2(128, canvasSize.y - 128));
    _star = Star();
    world.add(_star);
    world.add(_ember);
    final watcher = DirectoryWatcher("assets/images");
    watcher.events.listen((event) async {
      final image = event.path.split("/").last;
      images.clear(image);
      await images.load(image);
    },);
  }

  @override
  void onRemove() {
    // Optional based on your game needs.
    removeAll(children);
    processLifecycleEvents();
    images.clearCache();
    assets.clearCache();
    // Any other code that you want to run when the game is removed.
  }
}
