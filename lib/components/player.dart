import 'package:bonfire/bonfire.dart';
import 'dart:async' as ac;

import '../animations/player.dart';
import '../game.dart';
import '../main.dart';
import 'ghost.dart';

Vector2 initialPosition = Vector2(tileSize, tileSize);
bool dead = false;

// Buff
bool buffed = false;
bool buffedWasSet = false; // Quando come o BigCoin
ac.Timer buffCountdown = ac.Timer(const Duration(seconds: 1), () {});

class PacManPlayer extends SimplePlayer with ObjectCollision {
  PacManPlayer()
      : super(
          speed: 90,
          position: initialPosition,
          size: Vector2(tileSize, tileSize),
          initDirection: Direction.down,
          animation: SimpleDirectionAnimation(
            idleRight: PlayerAnimations.right,
            runRight: PlayerAnimations.right,
            idleLeft: PlayerAnimations.left,
            runLeft: PlayerAnimations.left,
            idleUp: PlayerAnimations.up,
            runUp: PlayerAnimations.up,
            runDown: PlayerAnimations.down,
            idleDown: PlayerAnimations.down,
          ),
        ) {
    aboveComponents = true;
    priority = 1;

    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(30, 30),
            align: Vector2(4, 6),
          )
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    _setBuff();
    super.update(dt);
  }

  void killPlayer() {
    lifes--;
    lifes <= 0 ? gameOver = true : player.position = initialPosition;

    unsetBuff();

    // Delay para não colidir novamente e tirar mais vidas
    ac.Timer(const Duration(milliseconds: 500), () => {dead = false});
  }

  /// Inicia o estado de "buff" do pacman e define quanto tempo ficará nele.
  void _setBuff() {
    if (buffedWasSet) {
      replaceGhostsAnimations(gameRef, color: 'blue');
      buffed = true;
      buffCountdown = ac.Timer(const Duration(seconds: 4), () {
        replaceGhostsAnimations(gameRef);
        buffed = false;
      });
      buffedWasSet = false;
    }
    buffed ? speed = 150 : speed = 90;
  }
}

/// Seta o modo "buff" do pacman para falso.
void unsetBuff() {
  buffedWasSet = false;
  buffCountdown.cancel();
}
