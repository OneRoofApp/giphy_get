import 'package:flutter/material.dart';

class SearchAppBarStyle extends ThemeExtension<SearchAppBarStyle> {
  const SearchAppBarStyle({
    this.backgroundColor,
    this.inputBackgroundColor,
    this.inputTextStyle,
    this.inputCursorColor,
    this.inputHintStyle,
    this.prefixIconBuilder,
    this.borderRadius,
    this.inputHeight
  });

  final Color? backgroundColor;
  final Color? inputBackgroundColor;
  final TextStyle? inputTextStyle;
  final Color? inputCursorColor;
  final TextStyle? inputHintStyle;
  final WidgetBuilder? prefixIconBuilder;
  final double? borderRadius;
  final double? inputHeight;

  @override
  ThemeExtension<SearchAppBarStyle> lerp(
      ThemeExtension<SearchAppBarStyle>? other, double t) {
    if (other is! SearchAppBarStyle) {
      return this;
    }

    final double defaultSize = inputHeight ?? 40;
    final double defaultBorderRadius = borderRadius ?? 0;
    return SearchAppBarStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      inputBackgroundColor:
          Color.lerp(inputBackgroundColor, other.inputBackgroundColor, t),
      inputTextStyle: TextStyle.lerp(inputTextStyle, other.inputTextStyle, t),
      inputHintStyle: TextStyle.lerp(inputHintStyle, other.inputHintStyle, t),
      prefixIconBuilder: other.prefixIconBuilder,
      inputHeight: other.inputHeight != null ? ((other.inputHeight! - defaultSize) * t) + defaultSize : inputHeight,
      borderRadius: other.borderRadius != null
          ? ((other.borderRadius! - defaultBorderRadius) * t)
          : borderRadius,
    );
  }

  @override
  SearchAppBarStyle copyWith({Color? color, double? size}) => SearchAppBarStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        inputBackgroundColor: inputBackgroundColor ?? this.inputBackgroundColor,
        inputTextStyle: inputTextStyle ?? this.inputTextStyle,
        inputCursorColor: inputCursorColor ?? this.inputCursorColor,
        inputHintStyle: inputHintStyle ?? this.inputHintStyle,
        prefixIconBuilder: prefixIconBuilder ?? this.prefixIconBuilder,
      );

  @override
  String toString() =>
      'SearchAppBarStyle(searchBackgroundColor: $backgroundColor, searchInputBackgroundColor: $inputBackgroundColor, inputTextStyle: $inputTextStyle, searchInputCursorColor: $inputCursorColor, inputHintStyle: $inputHintStyle)';
}
