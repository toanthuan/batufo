import 'package:batufo/models/player_model.dart';

class GameModel {
  final PlayerModel player;

  GameModel({this.player});

  String toString() {
    return '''GameModel {
    player: $player
    }''';
  }
}