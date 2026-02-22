import 'dart:async';

import 'package:ember_quest/ember_quest.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:watcher/watcher.dart';

class Star extends SpriteComponent with HasGameReference<EmberQuestGame> {
  Star() : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache("star.png"));
    position = Vector2(game.size.x / 2, game.size.y / 2);
    var watcher = FileWatcher("assets/images/star.png");
    watcher.events.listen(reloadSprite);
    add(
      SizeEffect.by(
        Vector2.all(-24),
        EffectController(
          duration: .75,
          reverseDuration: .5,
          infinite: true,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  void reloadSprite(WatchEvent event) async {
    await game.images.ready();
    sprite = Sprite(game.images.fromCache("star.png"));
  }
}
