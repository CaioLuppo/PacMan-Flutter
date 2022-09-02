import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pacman/configs.dart';
import 'package:pacman/game.dart';

/// Tamanho do tile do mapa. Pode ser usado por outras classes.
const double tileSize = 40;

/// Lista de widgets para representar a vida do personagem.
List<Widget> lifeImages = [];

void main() {
  runApp(const PacMan());
  fixScreen();
  const AlertDialog(
    title: Text("data"),
  );
}

class PacMan extends StatefulWidget {
  const PacMan({super.key});

  @override
  State<PacMan> createState() => _PacManState();
}

class _PacManState extends State<PacMan> {
  // Código para atualizar os valores na tela a cada segundo.

  // ignore: unused_field
  Timer _timer = Timer(const Duration(seconds: 1), (() {}));
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(microseconds: 800),
      (Timer timer) => setState(() => setLifeImages()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pac-man Flutter - By: Caio Luppo',

      // Tema
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 5, 16, 66),
      ),

      // Tela do jogo
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 64, 8),
                child: Row(
                  children: [
                    const Text(
                      "LIFES: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: lifeImages,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(64, 8, 8, 8),
                child: Text(
                  "SCORE: $score",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const PacManGame(),
      ),
    );
  }
}
