///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 4/2/21 12:48 PM
///
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Icon Grid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestIconGridPage(),
    );
  }
}

class TestIconGridPage extends StatefulWidget {
  const TestIconGridPage({Key? key}) : super(key: key);

  @override
  _TestIconGridPageState createState() => _TestIconGridPageState();
}

class _TestIconGridPageState extends State<TestIconGridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          const _ItemGridView(
            items: <_ItemData>[
              _ItemData(icon: Icons.android, label: '测试1'),
              _ItemData(icon: Icons.domain, label: '测试2'),
              _ItemData(icon: Icons.portrait, label: '测试3'),
              _ItemData(icon: Icons.landscape, label: '测试4'),
              _ItemData(icon: Icons.android, label: '测试1'),
              _ItemData(icon: Icons.domain, label: '测试2'),
              _ItemData(icon: Icons.portrait, label: '测试3'),
              _ItemData(icon: Icons.landscape, label: '测试4'),
              _ItemData(icon: Icons.android, label: '测试1'),
              _ItemData(icon: Icons.domain, label: '测试2'),
              _ItemData(icon: Icons.portrait, label: '测试3'),
              _ItemData(icon: Icons.landscape, label: '测试4'),
            ],
            shouldAdaptLastPageHeight: true,
          ),
          Expanded(child: Container(color: Colors.green)),
        ],
      ),
    );
  }
}

class _ItemData {
  const _ItemData({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class _ItemBuilder extends StatelessWidget {
  const _ItemBuilder({
    Key? key,
    required this.item,
    required this.height,
  }) : super(key: key);

  final _ItemData item;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(item.icon),
          Text(item.label),
        ],
      ),
    );
  }
}

class _ItemGridView extends StatefulWidget {
  const _ItemGridView({
    Key? key,
    required this.items,
    this.mainAxisCount = 2,
    this.crossAxisCount = 5,
    this.itemHeight = 60,
    this.shouldAdaptLastPageHeight = false,
    this.withIndicator = true,
    this.indicatorBuilder,
  })  : assert(crossAxisCount > 0),
        super(key: key);

  final List<_ItemData> items;

  /// 行数
  final int mainAxisCount;

  /// 列数
  final int crossAxisCount;

  /// 单个 item 的高度
  final double itemHeight;

  /// 是否需要根据最后一页的数量，自适应高度
  final bool shouldAdaptLastPageHeight;

  /// 是否需要指示器
  final bool withIndicator;

  /// 自定义指示器构建
  final PreferredSizeWidget Function(PageController controller, int pageCount)?
      indicatorBuilder;

  @override
  _ItemGridViewState createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<_ItemGridView> {
  final ValueNotifier<double> _page = ValueNotifier<double>(0);
  late final PageController _pgc = PageController()
    ..addListener(() {
      if (_pgc.hasClients) {
        _page.value = _pgc.page!;
      }
    });

  /// 共计高度
  double get _height => widget.mainAxisCount * widget.itemHeight;

  /// 每页的 item 数量
  int get _countPerPage => widget.mainAxisCount * widget.crossAxisCount;

  /// 共计页数
  int get _pageCount => (widget.items.length / _countPerPage).ceil();

  /// 最后一页需要放置的 item 数量
  int get _lastPageItemsCount => widget.items.length % _countPerPage;

  /// 最后一页的实际占位高度
  double get _lastPageHeight =>
      (_lastPageItemsCount / widget.crossAxisCount).ceil() * widget.itemHeight;

  /// 是否存在不铺满一页的最后一页
  bool get hasLastPage => _lastPageItemsCount > 0;

  /// 指示器
  PreferredSizeWidget get _effectiveIndicator =>
      widget.indicatorBuilder?.call(_pgc, _pageCount) ??
      _DotsIndicator(controller: _pgc, itemCount: _pageCount);

  /// 计算当前页实际需要的高度
  ///
  /// 如果是最后一页，则实时计算滚动的过程，来合成高度。
  double _currentPageHeight(double page, bool isLastPage) {
    double height;
    if (_pageCount == 1 && hasLastPage) {
      height = _lastPageHeight;
    } else if (hasLastPage &&
        page > _pageCount - 2 &&
        widget.shouldAdaptLastPageHeight) {
      height = lerpDouble(
        _height,
        _lastPageHeight,
        isLastPage ? 1 : page - page.floor(),
      )!;
    } else {
      height = _height;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _page,
      builder: (_, double page, Widget? child) => ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: _currentPageHeight(page, page == _pageCount - 1) +
              (widget.withIndicator
                  ? _effectiveIndicator.preferredSize.height
                  : 0),
        ),
        child: child!,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: LayoutBuilder(
              builder: (_, BoxConstraints constraints) => PageView.builder(
                controller: _pgc,
                itemCount: _pageCount,
                itemBuilder: (_, int i) => Wrap(
                  children: List<Widget>.generate(
                    // 当为最后一页且最后一页不铺满时，使用最后一页的计数。
                    i == _pageCount - 1 && hasLastPage
                        ? _lastPageItemsCount
                        : _countPerPage,
                    (int index) => ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                        width: constraints.maxWidth / widget.crossAxisCount,
                      ),
                      child: _ItemBuilder(
                        item: widget.items[i * _countPerPage + index],
                        height: widget.itemHeight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.withIndicator)
            ConstrainedBox(
              constraints: BoxConstraints.tight(
                _effectiveIndicator.preferredSize,
              ),
              child: _effectiveIndicator,
            ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends AnimatedWidget implements PreferredSizeWidget {
  const _DotsIndicator({
    required this.controller,
    required this.itemCount,
    this.itemWidth = 30.0,
    this.onPageSelected,
    this.maxWidth = 24.0,
    this.height = 20.0,
    this.size = 8.0,
    this.color = Colors.black,
    this.colors,
    this.unselectedColor = Colors.grey,
  })  : assert(
          color == null || colors == null,
          'Cannot provide color and colors at the same time.',
        ),
        super(listenable: controller);

  /// The [PageController] that this [DotsIndicator] is representing.
  final PageController controller;

  /// The number of items managed by the [controller].
  final int itemCount;

  /// The width for each dot.
  final double itemWidth;

  /// Called when a dot is tapped.
  final ValueChanged<int>? onPageSelected;

  /// The maximum width of the indicator.
  final double maxWidth;

  /// The height of the indicator.
  final double height;

  /// The color of the dots.
  /// Defaults to [Colors.black].
  final Color? color;

  final List<Color>? colors;

  /// The color of the dots which is unselected.
  /// Defaults to [Colors.grey.
  final Color unselectedColor;

  /// The size of the dots.
  final double size;

  void _onPageSelected(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget _buildDot(int index) {
    final num page =
        (controller.hasClients ? controller.page : 0) ?? controller.initialPage;
    final double unselected = Curves.easeOut.transform(
      math.max(0.0, 1.0 - (page - index).abs()),
    );
    final double zoom = 1.0 + (maxWidth / size - 1.0) * unselected;
    List<Color>? _colors;
    if (colors != null) {
      _colors = <Color>[
        Color.lerp(unselectedColor, colors![0], unselected)!,
        Color.lerp(unselectedColor, colors![1], unselected)!,
      ];
    }
    return SizedBox(
      width: itemWidth,
      child: Center(
        child: Container(
          width: size * zoom,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size),
            color: _colors == null
                ? Color.lerp(unselectedColor, color, unselected)
                : (color ?? unselectedColor),
            gradient: (_colors != null)
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _colors,
                  )
                : null,
          ),
          child: GestureDetector(onTap: () => _onPageSelected(index)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, _buildDot),
      ),
    );
  }

  @override
  Size get preferredSize => Size(itemWidth * itemCount, height);
}
