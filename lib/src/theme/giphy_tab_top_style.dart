import 'package:flutter/material.dart';

class GiphyTabTopStyle extends ThemeExtension<GiphyTabTopStyle> {
  const GiphyTabTopStyle({
    this.lineColor,
  });

  final Color? lineColor;

  @override
  ThemeExtension<GiphyTabTopStyle> lerp(
      ThemeExtension<GiphyTabTopStyle>? other, double t) {
    if (other is! GiphyTabTopStyle) {
      return this;
    }

    return GiphyTabTopStyle(
      lineColor: Color.lerp(lineColor, other.lineColor, t),
    );
  }

  @override
  GiphyTabTopStyle copyWith({Color? color, double? size}) => GiphyTabTopStyle(
    lineColor: lineColor ?? this.lineColor,
  );

  @override
  String toString() =>
      'GiphyTabTopStyle(canvasColor: $lineColor)';
}