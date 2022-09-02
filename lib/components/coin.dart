import 'package:bonfire/bonfire.dart';
import 'package:pacman/game.dart';

class Coin extends GameComponent with Sensor, UseSprite {
  Vector2 coinPosition = Vector2(0, 0);

  Coin(this.coinPosition) {
    position = coinPosition;
    size = Vector2(40, 40);
    setupSensorArea(
        areaSensor: [CollisionArea.circle(radius: 15, align: Vector2(5, 5))]);
  }

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load(
      'itens/coin.png',
      srcPosition: Vector2(-8.5, -8.5),
      srcSize: Vector2.all(40),
    );
    return super.onLoad();
  }

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      score += 10;
      checkWin();
      removeFromParent();
    }
  }

  @override
  void onContactExit(GameComponent component) {
    return;
  }
}

void checkWin() {
  coinsColectted += 1;
  if (coinsColectted == 82) {
    won = true;
  }
}
