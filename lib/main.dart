import 'package:batufo/engine/game_widget.dart';
import 'package:batufo/engine/images.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game/batufo_game.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/levels/levels.dart';
import 'package:batufo/levels/tilemap.dart';
import 'package:batufo/models/create_model.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Images.instance.loadAll(['assets/images/sprites/player.png']);

  final tilemap = Tilemap.build(Levels.simple);
  debugPrint('$tilemap');
  WorldPosition.tileSize = GameProps.tileSize;
  final gameModel = createModel(tilemap, GameProps.tileSize);
  final game = BatufoGame(gameModel);
  runApp(MyApp(game: game));
}

class MyApp extends StatelessWidget {
  final BatufoGame game;
  MyApp({@required this.game});

  Widget build(BuildContext context) {
    return GameWidget(
      game,
      background: Colors.tealAccent,
    );
  }
}