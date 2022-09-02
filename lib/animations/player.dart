import 'package:bonfire/bonfire.dart';

class PlayerAnimations {
  static Future<SpriteAnimation> _animation(String imageFile) {
    return SpriteAnimation.load(
      'player/$imageFile',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.15,
        textureSize: Vector2(20, 20),
        texturePosition: Vector2(0, 0),
      ),
    );
  }

  static Future<SpriteAnimation> get right => _animation("PacRight.png");
  static Future<SpriteAnimation> get left => _animation("PacLeft.png");
  static Future<SpriteAnimation> get down => _animation("PacDown.png");
  static Future<SpriteAnimation> get up => _animation("PacUp.png");

}
