import 'dart:ui' show Canvas, Offset, Paint, Rect, Image;

import 'package:batufo/engine/images.dart';
import 'package:batufo/game_props.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;

final Paint _paint = Paint()..color = Colors.white;

class Sprite {
  Image image;
  bool _loaded;
  Rect src;

  Sprite(
    String path, {
    double x = 0.0,
    double y = 0.0,
    double width,
    double height,
  }) : _loaded = false {
    final img = Images.instance.getImage(path);
    _init(img, x, y, width, height);
  }

  Sprite.fromImage(
    Image img, {
    double x = 0.0,
    double y = 0.0,
    double width,
    double height,
  }) {
    _init(img, x, y, width, height);
  }

  static Sprite fromPath(
    String path, {
    double width,
    double height,
  }) {
    final img = Images.instance.getImage(path);
    return Sprite.fromImage(img, width: width, height: height);
  }

  void renderRect(Canvas canvas, Rect rect) {
    render(
      canvas,
      rect.center,
      width: rect.size.width,
      height: rect.size.height,
    );
  }

  void render(Canvas canvas, Offset center,
      {@required double width, @required double height}) {
    if (!_loaded) return;
    final x = center.dx;
    final y = center.dy;
    final dst = Rect.fromLTWH(x - width / 2, y - height / 2, width, height);
    canvas.drawImageRect(image, src, dst, _paint);
  }

  void _init(Image img, double x, double y, double width, double height) {
    image = img;
    width ??= img.width.toDouble();
    height ??= img.height.toDouble();
    src = Rect.fromLTWH(x, y, width, height);
    _loaded = true;
  }

  static Sprite fromImageAsset(ImageAsset asset) {
    assert(asset.rows == 1, 'needs to have one row exactly');
    assert(asset.cols == 1, 'needs to have one col exactly');
    return Sprite(
      asset.imagePath,
      x: 0,
      y: 0,
      width: asset.width.toDouble(),
      height: asset.height.toDouble(),
    );
  }
}
