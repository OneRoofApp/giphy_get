import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get/src/client/models/type.dart';
import 'package:giphy_get/src/l10n/l10n.dart';
import 'package:giphy_get/src/providers/app_bar_provider.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:giphy_get/src/theme/search_app_bar_style.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatefulWidget {
  // Scroll Controller
  final ScrollController scrollController;

  SearchAppBar({Key? key, required this.scrollController}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  // Tab Provider
  late TabProvider _tabProvider;

  // AppBar Provider
  late AppBarProvider _appBarProvider;

  // Sheet Provider
  late SheetProvider _sheetProvider;

  // Input controller
  late TextEditingController _textEditingController;

  // Input Focus
  final FocusNode _focus = new FocusNode();

  @override
  void initState() {
    // Focus
    _focus.addListener(_focusListener);

    //Set Texfielf
    _textEditingController = new TextEditingController(
        text: Provider.of<AppBarProvider>(context, listen: false).queryText);

    // Listener TextField
    _textEditingController.addListener(() {
      if (_appBarProvider.queryText != _textEditingController.text) {
        _appBarProvider.queryText = _textEditingController.text;
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Providers
    _tabProvider = Provider.of<TabProvider>(context);

    _sheetProvider = Provider.of<SheetProvider>(context);

    // AppBar Provider
    _appBarProvider = Provider.of<AppBarProvider>(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchAppBarStyle? overrideStyle =
        Theme.of(context).extension<SearchAppBarStyle>();

    return Container(
      color: overrideStyle?.backgroundColor,
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 10),
      child: _searchWidget(overrideStyle),
    );
  }

  Widget _searchWidget(SearchAppBarStyle? overrideStyle) {
    final l = GiphyGetUILocalizations.labelsOf(context);
    final prefixIcon = overrideStyle?.prefixIconBuilder != null
        ? overrideStyle!.prefixIconBuilder!(context)
        : _searchIcon();

    return Column(
      children: [
        _tabProvider.tabType == GiphyType.emoji
            ? Container()
            : SizedBox(
                height: overrideStyle?.inputHeight ?? 40,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        overrideStyle?.borderRadius ?? 10),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      autofocus: _sheetProvider.initialExtent ==
                          SheetProvider.maxExtent,
                      focusNode: _focus,
                      controller: _textEditingController,
                      style: overrideStyle?.inputTextStyle,
                      cursorColor: overrideStyle?.inputCursorColor,
                      decoration: InputDecoration(
                        fillColor: overrideStyle?.inputBackgroundColor,
                        filled: true,
                        prefixIcon: prefixIcon,
                        hintText: l.searchInputLabel,
                        hintStyle: overrideStyle?.inputHintStyle,
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: overrideStyle?.inputHintStyle?.color ??
                                  Theme.of(context).textTheme.bodyText1!.color!,
                            ),
                            onPressed: () {
                              setState(() {
                                _textEditingController.clear();
                              });
                            }),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      autocorrect: false,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _searchIcon() {
    if (kIsWeb) {
      return Icon(Icons.search);
    } else {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFF6666),
              Color(0xFF9933FF),
            ]).createShader(bounds),
        child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Icon(
              Icons.search,
              color: Colors.white,
            )),
      );
    }
  }

  void _focusListener() {
    // Set to max extent height if Textfield has focus
    if (_focus.hasFocus &&
        _sheetProvider.initialExtent == SheetProvider.minExtent) {
      _sheetProvider.initialExtent = SheetProvider.maxExtent;
    }
    print("Focus : ${_focus.hasFocus}");
  }
}
