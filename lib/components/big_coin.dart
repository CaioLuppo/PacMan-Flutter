import 'package:bonfire/bonfire.dart';
import 'package:pacman/components/coin.dart';
import 'package:pacman/components/ghost.dart';
import 'package:pacman/components/player.dart';
import 'package:pacman/game.dart';

class BigCoin extends GameComponent with Sensor, UseSprite {
  Vector2 bigCoinPosition = Vector2(0, 0);

  BigCoin(this.bigCoinPosition) {
    position = bigCoinPosition;
    size = Vector2(40, 40);
    setupSensorArea(
        areaSensor: [CollisionArea.circle(radius: 15, align: Vector2(5, 5))]);
  }
  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load(
      'itens/coin.png',
      srcPosition: Vector2.all(0.5),
      srcSize: Vector2.all(20),
    );

    return super.onLoad();
  }

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      for (var element in gameRef.children) {
        // Deixa os fantasmas "com medo"
        if (element is Ghost) {
          element.wasAte = false;
        }
      }

      score += 50;
      checkWin();

      buffCountdown.cancel(); // Para o timer para que possa continuar buffado
      buffedWasSet = true;

      removeFromParent();
    }
  }

  @override
  void onContactExit(GameComponent component) {
    return;
  }
}
