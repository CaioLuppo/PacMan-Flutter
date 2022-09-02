import 'package:bonfire/bonfire.dart';

class GhostAnimations {
  static Future<SpriteAnimation> _animation(String imageFile) {
    return SpriteAnimation.load(
      'ghosts/$imageFile',
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2(20, 20),
        texturePosition: Vector2(0, 0),
      ),
    );
  }

  static Future<SpriteAnimation> right(String color) => _animation("$color/direita.png");
  static Future<SpriteAnimation> left(String color) => _animation("$color/esquerda.png");
  static Future<SpriteAnimation> down(String color) => _animation("$color/baixo.png");
  static Future<SpriteAnimation> up(String color) => _animation("$color/cima.png");

}
