///
/// [Author] Alex (https://github.com/AlexV525)
/// [Date] 2021/8/6 10:16
///
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

class TestLoadingMoreListPage extends StatefulWidget {
  const TestLoadingMoreListPage({Key? key}) : super(key: key);

  @override
  _TestLoadingMoreListPageState createState() =>
      _TestLoadingMoreListPageState();
}

class _TestLoadingMoreListPageState extends State<TestLoadingMoreListPage> {
  final LoadingBase lb = LoadingBase(request: (int page) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final int startFrom = (page - 1) * 10;
    return List<String>.generate(10, (int i) => (startFrom + i).toString());
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading More List')),
      body: RefreshListWrapper(
        loadingBase: lb,
        itemBuilder: (String m) => Container(
          alignment: Alignment.center,
          height: 100,
          color: Theme.of(context).primaryColor,
          child: Text(m),
        ),
        dividerBuilder: (_, int i) => const Divider(),
      ),
    );
  }
}

class RefreshListWrapper extends StatelessWidget {
  const RefreshListWrapper({
    Key? key,
    required this.loadingBase,
    required this.itemBuilder,
    this.dividerBuilder,
    this.refreshHeaderTextStyle,
    this.indicatorPlaceholder,
    this.indicatorIcon,
    this.indicatorPackage,
    this.indicatorText,
    this.indicatorTextStyle,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.enableRefresh = true,
  }) : super(key: key);

  final LoadingBase loadingBase;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final Widget Function(String model) itemBuilder;

  final IndexedWidgetBuilder? dividerBuilder;
  final TextStyle? refreshHeaderTextStyle;
  final Widget Function(bool isError)? indicatorPlaceholder;
  final String Function(bool isError)? indicatorIcon;
  final String? Function(bool isError)? indicatorPackage;
  final String Function(bool isError)? indicatorText;
  final TextStyle? indicatorTextStyle;

  /// 是否启用刷新（默认启用）
  ///
  /// 有一些特殊的场景，需要一个不分页的列表，但需要占位和错误提示，可以设置为 false。
  final bool enableRefresh;

  EdgeInsetsGeometry? _buildEffectivePadding(BuildContext context) {
    EdgeInsetsGeometry? _padding = padding;
    if (padding == null) {
      final MediaQueryData mediaQuery = MediaQuery.of(context);
      // Automatically pad sliver with padding from MediaQuery.
      final EdgeInsets mediaQueryHorizontalPadding =
          mediaQuery.padding.copyWith(top: 0.0, bottom: 0.0);
      final EdgeInsets mediaQueryVerticalPadding =
          mediaQuery.padding.copyWith(left: 0.0, right: 0.0);
      // Consume the main axis padding with SliverPadding.
      _padding = scrollDirection == Axis.vertical
          ? mediaQueryVerticalPadding
          : mediaQueryHorizontalPadding;
    }
    return _padding;
  }

  Widget indicatorBuilder(
    BuildContext context,
    IndicatorStatus status,
  ) {
    final Widget indicator;
    switch (status) {
      case IndicatorStatus.none:
        indicator = const SizedBox.shrink();
        break;
      case IndicatorStatus.loadingMoreBusying:
        indicator = ListMoreIndicator(
          isSliver: false,
          isRequesting: true,
          textStyle: indicatorTextStyle,
        );
        break;
      case IndicatorStatus.fullScreenBusying:
        indicator = ListMoreIndicator(
          isRequesting: true,
          textStyle: indicatorTextStyle,
        );
        break;
      case IndicatorStatus.error:
        indicator = ListEmptyIndicator(
          isSliver: false,
          isError: true,
          loadingBase: loadingBase,
          indicator: indicatorPlaceholder,
          indicatorIcon: indicatorIcon,
          indicatorPackage: indicatorPackage,
          indicatorText: indicatorText,
          textStyle: indicatorTextStyle,
        );
        break;
      case IndicatorStatus.fullScreenError:
        indicator = ListEmptyIndicator(
          isError: true,
          loadingBase: loadingBase,
          indicator: indicatorPlaceholder,
          indicatorIcon: indicatorIcon,
          indicatorPackage: indicatorPackage,
          indicatorText: indicatorText,
          textStyle: indicatorTextStyle,
        );
        break;
      case IndicatorStatus.noMoreLoad:
        if (loadingBase.isOnlyFirstPage) {
          indicator = const SizedBox.shrink();
        } else {
          indicator = ListMoreIndicator(
            isSliver: false,
            textStyle: indicatorTextStyle,
          );
        }
        break;
      case IndicatorStatus.empty:
        indicator = ListEmptyIndicator(
          loadingBase: loadingBase,
          indicator: indicatorPlaceholder,
          indicatorIcon: indicatorIcon,
          indicatorPackage: indicatorPackage,
          indicatorText: indicatorText,
          textStyle: indicatorTextStyle,
        );
        break;
    }
    return indicator;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMoreCustomScrollView(
      scrollDirection: scrollDirection,
      rebuildCustomScrollView: true,
      slivers: <Widget>[
        LoadingMoreSliverList<String>(
          SliverListConfig<String>(
            sourceList: loadingBase,
            itemBuilder: (BuildContext c, String model, int index) {
              if (dividerBuilder == null) {
                return itemBuilder(model);
              }
              if (index.isEven) {
                return itemBuilder(loadingBase[index ~/ 2]);
              }
              return dividerBuilder!(c, index);
            },
            indicatorBuilder: indicatorBuilder,
            childCountBuilder: dividerBuilder != null
                ? (int length) => math.max(0, length * 2 - 1)
                : null,
            padding: padding ?? _buildEffectivePadding(context),
          ),
        ),
      ],
    );
  }
}

class ListMoreIndicator extends StatelessWidget {
  const ListMoreIndicator({
    Key? key,
    this.isSliver = true,
    this.isRequesting = false,
    this.textStyle,
  }) : super(key: key);

  final bool isSliver;
  final bool isRequesting;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    Widget child;
    child = SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: kTabScrollDuration,
            child: isRequesting
                ? SizedBox.fromSize(
                    size: const Size.square(50),
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ),
          AnimatedContainer(
            duration: kTabScrollDuration,
            width: isRequesting ? 10 : 0,
          ),
          Text(isRequesting ? '加载中...' : '已经到底啦'),
        ],
      ),
    );
    if (isSliver) {
      child = SliverFillRemaining(child: Center(child: child));
    }
    return DefaultTextStyle(
      style: textStyle ??
          TextStyle(
            color: Theme.of(context).dividerColor.withOpacity(0.375),
            fontSize: 14,
            height: 1.4,
          ),
      child: child,
    );
  }
}

class ListEmptyIndicator extends StatelessWidget {
  const ListEmptyIndicator({
    Key? key,
    this.isSliver = true,
    this.isError = false,
    this.loadingBase,
    this.indicator,
    this.indicatorIcon,
    this.indicatorPackage,
    this.indicatorText,
    this.textStyle,
    this.onTap,
  }) : super(key: key);

  final bool isSliver;
  final bool isError;
  final LoadingBase? loadingBase;
  final Widget Function(bool isError)? indicator;
  final String Function(bool isError)? indicatorIcon;
  final String? Function(bool isError)? indicatorPackage;
  final String Function(bool isError)? indicatorText;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  static const String EMPTY_TEXT = '空空如也';
  static const String ERROR_TEXT = '网络出错了~点此重试';

  @override
  Widget build(BuildContext context) {
    Widget child;
    String? _text = indicatorText?.call(isError);
    _text ??= isError ? ERROR_TEXT : EMPTY_TEXT;
    child = GestureDetector(
      onTap: isError
          ? () {
              if (onTap != null) {
                onTap!();
              } else {
                loadingBase
                  ?..refresh()
                  ..isLoading = true
                  ..setState();
              }
            }
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (indicator != null)
            indicator!(isError)
          else ...<Widget>[
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              size: 150,
            ),
            const SizedBox(height: 20),
            Text(_text),
          ],
        ],
      ),
    );
    if (isSliver) {
      child = SliverFillRemaining(child: child);
    }
    return DefaultTextStyle(
      style: textStyle ??
          Theme.of(context).textTheme.caption!.copyWith(
                fontSize: 17,
                height: 1.4,
              ),
      textAlign: TextAlign.center,
      child: child,
    );
  }
}

class LoadingBase extends LoadingMoreBase<String> {
  LoadingBase({
    required this.request,
    this.onRefresh,
    this.onLoadSucceed,
    this.onLoadFailed,
  });

  Future<List<String>> Function(int page) request;
  final VoidCallback? onRefresh;
  final Function(LoadingBase lb, bool isMore)? onLoadSucceed;
  final Function(LoadingBase lb, bool isMore, Object e)? onLoadFailed;

  int total = 0;
  int page = 1;
  bool canRequestMore = true;
  bool forceRefresh = false;

  @override
  bool get hasMore => canRequestMore;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    canRequestMore = true;
    page = 1;
    forceRefresh = !clearBeforeRequest;
    onRefresh?.call();
    final bool result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    final List<String> response = await request(
      isLoadMoreAction ? page + 1 : page,
    );
    if (!isLoadMoreAction) {
      clear();
    }
    addAll(response);
    total += response.length;
    page += 1;
    canRequestMore = true;
    setState();
    onLoadSucceed?.call(this, isLoadMoreAction);
    return true;
  }

  bool get isOnlyFirstPage => page == 1 && !hasMore;
}
