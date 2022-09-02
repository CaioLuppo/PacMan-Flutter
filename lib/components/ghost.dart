import 'dart:async' as ac;

import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:bonfire/bonfire.dart';

import 'package:pacman/components/player.dart';
import 'package:pacman/game.dart';
import '../animations/ghost.dart';
import '../main.dart';

Vector2 ghostPos = Vector2(390, 150);
double vision = 80;

class Ghost extends SimpleEnemy
    with ObjectCollision, MoveToPositionAlongThePath, AutomaticRandomMovement {
  String color = '';
  bool wasAte = false;

  Ghost(this.color)
      : super(
          position: ghostPos,
          speed: 70,
          size: Vector2(tileSize, tileSize),
          animation: SimpleDirectionAnimation(
            idleRight: GhostAnimations.right(color),
            runRight: GhostAnimations.right(color),
            runLeft: GhostAnimations.left(color),
            idleLeft: GhostAnimations.left(color),
            runDown: GhostAnimations.down(color),
            idleDown: GhostAnimations.down(color),
            runUp: GhostAnimations.up(color),
            idleUp: GhostAnimations.up(color),
          ),
        ) {
    aboveComponents = true;
    priority = 20;

    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(30, 30),
            align: Vector2(4, 6),
          ),
        ],
      ),
    );
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    if (component is Ghost) {
      // Se for fantasma
      return false;
    } else if (component is Player) {
      // Se for player
      if (buffed && !wasAte) {
        position = ghostPos;
        score += 200;
        wasAte = true;
        replaceAnimation(loadGhostAnimations(color));
      } else {
        if (!dead) {
          player.killPlayer();
          dead = true;

          // Reconfigura a visão, para que não fique em cima do player
          vision = 0;
          ac.Timer(const Duration(seconds: 3), () => vision = 80);
        }
      }
    }
    return super.onCollision(component, active);
  }


  @override
  void update(double dt) {
    if (!buffed) {
      seeAndMoveToPlayer(
        closePlayer: (pacman) {},
        margin: -1,
        notObserved: () {
          runRandomMovement(
            dt,
            maxDistance: 500,
            speed: speed,
            timeKeepStopped: 0,
          );
        },
        radiusVision: vision,
      );
    } else {
      runRandomMovement(
        dt,
        maxDistance: 500,
        speed: !wasAte ? speed + 40 : speed,
        timeKeepStopped: 0,
      );
    }
    super.update(dt);
  }
}

/// Retorna as animações do fantasma.
SimpleDirectionAnimation loadGhostAnimations(String ghostColor) {
  return SimpleDirectionAnimation(
    idleRight: GhostAnimations.right(ghostColor),
    runRight: GhostAnimations.right(ghostColor),
    runLeft: GhostAnimations.left(ghostColor),
    idleLeft: GhostAnimations.left(ghostColor),
    runDown: GhostAnimations.down(ghostColor),
    idleDown: GhostAnimations.down(ghostColor),
    runUp: GhostAnimations.up(ghostColor),
    idleUp: GhostAnimations.up(ghostColor),
  );
}

/// Troca a animação do fantasma. Se não informado, "color" será o default
/// do fantasma.
void replaceGhostsAnimations(BonfireGameInterface gameRef,
    {String color = ''}) {
  for (var element in gameRef.children) {
    if (element is Ghost) {
      color == ''
          ? element.replaceAnimation(loadGhostAnimations(element.color))
          : element.replaceAnimation(loadGhostAnimations(color));
    }
  }
}
