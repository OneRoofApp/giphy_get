import 'package:flutter/material.dart';

import 'giphy_tab_detail.dart';

class GiphyTabView extends StatelessWidget {
  final ScrollController scrollController;
  final TabController tabController;
  final List<String> tabs;

  const GiphyTabView({
    Key? key,
    required this.scrollController,
    required this.tabController,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: tabs
          .map(
            (type) => GiphyTabDetail(
              type: type,
              scrollController: scrollController,
              key: null,
            ),
          )
          .toList(),
    );
  }
}
