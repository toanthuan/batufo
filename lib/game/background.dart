import 'dart:ui' show Canvas, Rect;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/sprite_sheet.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game_props.dart';

class BackgroundSprite {
  final Rect rect;
  final Sprite sprite;

  BackgroundSprite(this.rect, this.sprite);

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }
}

class Background {
  final SpriteSheet _spriteSheet;
  final List<TilePosition> _floorTiles;
  final List<BackgroundSprite> _backgroundSprites;
  final double _tileSize;
  final bool _isActive;
  Background(this._floorTiles, this._tileSize, this._isActive)
      : _spriteSheet = SpriteSheet.fromImageAsset(GameProps.assets.floorTiles),
        _backgroundSprites = List<BackgroundSprite>() {
    _initTiles();
  }

  void render(Canvas canvas) {
    if (!_isActive) return;
    for (final bs in _backgroundSprites) {
      bs.render(canvas);
    }
  }

  void _initTiles() {
    if (!_isActive) return;

    _backgroundSprites.clear();

    final w = _tileSize;
    for (int i = 0; i < _floorTiles.length; i++) {
      final tile = _floorTiles[i];
      final wp = tile.toWorldPosition();
      final rect = Rect.fromLTWH(wp.x - w / 2, wp.y - w / 2, w, w);
      final nrows = 20;

      final sheetRow = i % 7;
      final sheetCol = (i ~/ nrows) % 7;
      final sprite = _spriteSheet.getRowCol(sheetRow, sheetCol);
      final backgroundSprite = BackgroundSprite(rect, sprite);
      _backgroundSprites.add(backgroundSprite);
    }
  }
}
