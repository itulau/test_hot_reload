import 'dart:async';

import 'package:ember_quest/ember_quest.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:watcher/watcher.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame>, KeyboardHandler, CollisionCallbacks {
  EmberPlayer({required super.position})
    : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache("ember.png"),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.12,
        textureSize: Vector2.all(16),
      ),
    );
    var watcher = FileWatcher("assets/images/ember.png");
    watcher.events.listen(reloadSprite,);
  }

  void reloadSprite(WatchEvent event) async {
    await game.images.ready();
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache("ember.png"),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.12,
        textureSize: Vector2.all(16),
      ),
    );
  }
}
