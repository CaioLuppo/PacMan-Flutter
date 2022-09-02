import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacman/components/big_coin.dart';
import 'package:pacman/components/player.dart';

import 'game.dart';
import 'components/ghost.dart';
import 'components/coin.dart';
import 'main.dart';

// Câmera e Tela
/// Deixa a tela em landscape e modo imersivo (sem as barras do celular).
Future fixScreen() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
}

/// Componente utilizado para ser o foco da câmera.
class GameCam extends GameComponent {
  @override
  void update(double dt) {
    gameRef.camera.zoom = 0.4 *
        MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height;
    position = Vector2(401, 200);
    super.update(dt);
  }
}

// Jogo

class GameProccess extends GameComponent {
  @override
  void update(double dt) {
    if (won) {
      endGame(
        context,
        gameRef,
        "Você venceu! 🥳",
        "Parabéns! Você ganhou o jogo com um score de: $score pontos!",
      );
      gameRef.pauseEngine();
    } else if (gameOver) {
      endGame(
        context,
        gameRef,
        "GAME OVER! 😿",
        "Que pena! Você perdeu com um score de: $score pontos...",
      );
      gameRef.pauseEngine();
    }
    super.update(dt);
  }
}

/// Reinicia o jogo informado.
void restartGame(BonfireGameInterface game) {
  // Reseta a posição dos componentes
  _resetGhosts();
  _resetCoins(game);
  player.position = initialPosition;

  // Zera a pontuação
  coinsColectted = 0;
  score = 0;
  lifes = 3;
  won = false;
  gameOver = false;

  unsetBuff(game);
}

/// Encerra o jogo
void endGame(BuildContext context, BonfireGameInterface game, String title,
    String message) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(

        title: Text(title),
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                coinsColectted = 0;
                game.resumeEngine();
                restartGame(game);
              },
              child: const Text("REINICIAR"))
        ],
      );
    },
  );
}

/// Realoca as moedas no mapa do jogo informado.
void _resetCoins(BonfireGameInterface game) {
  // Remove as moedas antes de colocar mais
  for (var element in game.children) {
    if (element is Coin || element is BigCoin) {
      element.removeFromParent();
    }
  }
  // Coloca as moedas
  List<Vector2> bigCoinPositions = [
    coinPos(1, 8),
    coinPos(6, 1),
    coinPos(10, 7),
    coinPos(18, 1),
    coinPos(18, 8),
  ];

  for (Vector2 coinPosition in coinPositions) {
    bigCoinPositions.contains(coinPosition)
        ? game.add(BigCoin(coinPosition))
        : game.add(Coin(coinPosition));
  }
}

/// Volta os fantasmas à sua posição inicial.
void _resetGhosts() {
  List<Ghost> ghosts = [blueGhost, orangeGhost, pinkGhost, greenGhost];
  for (Ghost ghost in ghosts) {
    ghost.position = ghostPos;
  }
}

/// Coloca as imagens na lista de vida.
void setLifeImages() {
  List<Image> images = [];
  for (int count = 0; count < lifes; count++) {
    images.add(
      Image.asset(
        "assets/images/player/LifeIndicator.png",
        scale: 0.5,
        filterQuality: FilterQuality.none,
      ),
    );
  }
  lifeImages = images;
}

// Moedas
/// Retorna uma posição no mapa baseada no tileset
/// (Ex: coinPos(1, 2) -> Vector2(40,80) ).
Vector2 coinPos(int column, int row) {
  return Vector2(tileSize * column, tileSize * row);
}

/// Posições possíveis para a moeda aparecer.
List<Vector2> coinPositions = [
  coinPos(1, 2),
  coinPos(1, 3),
  coinPos(1, 4),
  coinPos(1, 5),
  coinPos(1, 8),
  coinPos(2, 5),
  coinPos(2, 8),
  coinPos(3, 1),
  coinPos(3, 2),
  coinPos(3, 3),
  coinPos(3, 4),
  coinPos(3, 5),
  coinPos(3, 6),
  coinPos(3, 7),
  coinPos(3, 8),
  coinPos(4, 1),
  coinPos(4, 5),
  coinPos(4, 8),
  coinPos(5, 1),
  coinPos(5, 2),
  coinPos(5, 3),
  coinPos(5, 4),
  coinPos(5, 5),
  coinPos(5, 8),
  coinPos(6, 1),
  coinPos(6, 2),
  coinPos(6, 5),
  coinPos(6, 6),
  coinPos(6, 7),
  coinPos(6, 8),
  coinPos(7, 2),
  coinPos(7, 3),
  coinPos(7, 4),
  coinPos(7, 5),
  coinPos(7, 6),
  coinPos(7, 7),
  coinPos(8, 2),
  coinPos(8, 7),
  coinPos(9, 2),
  coinPos(9, 7),
  coinPos(10, 2),
  coinPos(10, 7),
  coinPos(11, 2),
  coinPos(11, 7),
  coinPos(12, 2),
  coinPos(12, 3),
  coinPos(12, 4),
  coinPos(12, 5),
  coinPos(12, 6),
  coinPos(12, 7),
  coinPos(13, 1),
  coinPos(13, 2),
  coinPos(13, 3),
  coinPos(13, 4),
  coinPos(13, 5),
  coinPos(13, 6),
  coinPos(13, 7),
  coinPos(13, 8),
  coinPos(14, 1),
  coinPos(14, 5),
  coinPos(14, 8),
  coinPos(15, 1),
  coinPos(15, 5),
  coinPos(15, 8),
  coinPos(16, 1),
  coinPos(16, 3),
  coinPos(16, 4),
  coinPos(16, 5),
  coinPos(16, 6),
  coinPos(16, 7),
  coinPos(16, 8),
  coinPos(17, 1),
  coinPos(17, 3),
  coinPos(17, 8),
  coinPos(18, 1),
  coinPos(18, 2),
  coinPos(18, 3),
  coinPos(18, 4),
  coinPos(18, 5),
  coinPos(18, 6),
  coinPos(18, 7),
  coinPos(18, 8),
];
