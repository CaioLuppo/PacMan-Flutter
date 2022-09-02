import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'components/ghost.dart';
import 'configs.dart';
import 'components/player.dart';

// Indicadores de vitória/derrota
int coinsColectted = 0;
bool won = false;
bool gameOver = false;

// Variáveis de score etc.
int score = 0;
int lifes = 3;

// Player e Fantasmans instanciados
PacManPlayer player = PacManPlayer();
Ghost blueGhost = Ghost("red");
Ghost orangeGhost = Ghost("orange");
Ghost greenGhost = Ghost("green");
Ghost pinkGhost = Ghost("pink");

// Câmera
GameCam camera = GameCam();

class PacManGame extends StatefulWidget {
  const PacManGame({super.key});
  @override
  State<PacManGame> createState() => _PacManGameState();
}

class _PacManGameState extends State<PacManGame> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      // Mapa e configurações
      map: WorldMapByTiled(
        'map/mapa.json',
        forceTileSize: Vector2(40, 40),
      ),
      cameraConfig: CameraConfig(
        target: camera,
        zoom: 0.4,
        sizeMovementWindow: Vector2(1, 1),
      ),
      onTapDown: (game, screenPosition, worldPosition) => fixScreen(),
      onReady: (game) {
        game.camera.zoom = 0.4 * MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
        restartGame(game);
      },

      // Player e fantasmas
      player: player,
      enemies: [
        blueGhost,
        orangeGhost,
        greenGhost,
        pinkGhost,
      ],
      components: [camera, GameProccess()],

      // Controle
      joystick: Joystick(
        keyboardConfig: KeyboardConfig(
            keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows),
        directional: JoystickDirectional(isFixed: false),
      ),

      // Informações na tela
    );
  }
}
