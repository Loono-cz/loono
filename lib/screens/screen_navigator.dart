import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loono/core/app_logger.dart';

/// Mainly used when building a screen opened via a deep link.
/// It returns null if the screen should not be accessed.
typedef PageBuilder = Page<Object>? Function(BuildContext);

/// Only used in this file to decide if a screen can be opened
extension _PageList on List<Page> {
  bool containsKey(LocalKey? key) => any((page) => page.key == key);
}

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({
    required this.initialPages,
    required GlobalKey<ScreenNavigatorState> key,
  }) : super(key: key);

  final List<Page<Object>> initialPages;

  static ScreenNavigatorState of(BuildContext context) {
    final value = context.findAncestorStateOfType<ScreenNavigatorState>();

    if (value == null) {
      throw 'Please add an instance of ScreenNavigator '
          'as a descendant of the MaterialApp.home parameter';
    }

    return value;
  }

  @override
  ScreenNavigatorState createState() => ScreenNavigatorState();
}

class ScreenNavigatorState extends State<ScreenNavigator> {
  final AppLogger _logger = AppLogger('ScreenNavigator');

  final _navigatorKey = GlobalKey<NavigatorState>();
  final _stack = <Page>[];
  final _onPop = <Page, Completer>{};

  @override
  void initState() {
    super.initState();
    assert(widget.initialPages.isNotEmpty);
    _stack.addAll(widget.initialPages);
  }

  bool isTopOfStack(String screenName) {
    return _stack.last.name == screenName;
  }

  bool isInStack(String screenName) {
    return _stack.any((page) => page.name == screenName);
  }

  void pushBuilders(List<PageBuilder> pageBuilders) {
    if (pageBuilders.isEmpty) {
      _logger.debug('pushBuilders called without builders to push');
      return;
    }

    final _pages = pageBuilders
        .map((builder) => builder(context))
        .where((page) => page != null)
        .toList();

    if (_pages.isNotEmpty) {
      for (final page in _pages) {
        if (page != null) {
          _stack.add(page);
          _logger.debug('pushBuilders: pushing ${page.name}');
        }
      }
      setState(() {});
    }
  }

  /// If you're expecting this page to return a value use [pushAsync]
  void push(Page page) {
    if (_stack.containsKey(page.key)) {
      _logger.debug(
        'push: cannot add two pages with the same key on the stack ${page.key}',
      );
      return;
    }

    _stack.add(page);
    _logger.debug('push: pushing ${page.name}');
    setState(() {});
  }

  Future<T?> pushAsync<T>(Page<T> page) async {
    if (_stack.containsKey(page.key)) {
      _logger.debug(
        'push: cannot add two pages with the same key on the stack ${page.key}',
      );
      return null;
    }

    final _completer = Completer<T>();
    _onPop[page] = _completer;
    setState(() => _stack.add(page));
    _logger.debug('pushAsync: pushing ${page.name}');
    return _completer.future;
  }

  void pushReplacement(Page page) {
    if (_stack.containsKey(page.key)) {
      _logger.debug(
        'push: cannot add two pages with the same key on the stack ${page.key}',
      );
      return;
    }

    final removedPage = _stack.removeLast();
    _logger.debug('pushReplacement: removed ${removedPage.name}');

    // Inherit the replaced page completer
    final removedCompleter = _onPop.remove(removedPage);
    if (removedCompleter != null) {
      _onPop[page] = removedCompleter;
    }

    _stack.add(page);
    _logger.debug('pushReplacement: pushing ${page.name}');
    setState(() {});
  }

  void pushAndRemoveUntil(Page page, {required Set<String> screenIsAny}) {
    if (_stack.containsKey(page.key)) {
      _logger.debug(
        'push: cannot add two pages with the same key on the stack ${page.key}',
      );
      return;
    }

    removeUntil(screenIsAny: screenIsAny);
    push(page);
  }

  void clearStackAndPushList(List<Page> pages) {
    _stack.clear();
    _onPop.clear();
    _logger.debug('clearStackAndPushList: stack cleared');

    _stack.addAll(pages);
    _logger.debug('clearStackAndPushList: pushed ${pages.map((p) => p.name)}');
    setState(() {});
  }

  /// Remove screens from the stack until a match is found in [screenIsAny].
  /// If no match is found this method does nothing.
  /// Return true if at least one screen in [screenIsAny] has a match.
  bool removeUntil({required Set<String> screenIsAny}) {
    final updatedStack = [..._stack];
    final updatedOnPop = {..._onPop};

    Completer? lastRemovedCompleter;

    for (final page in _stack.reversed) {
      if (screenIsAny.contains(page.name)) {
        break;
      } else {
        updatedStack.remove(page);
        lastRemovedCompleter = updatedOnPop.remove(page);
      }
    }

    if (updatedStack.isNotEmpty) {
      _logger.debug(
        'removeUntil: stack before removing ${_stack.map((p) => p.name)}',
      );

      _stack.clear();
      _onPop.clear();

      _stack.addAll(updatedStack);
      _onPop.addAll(updatedOnPop);

      // Inherit the last removed page completer if any
      if (lastRemovedCompleter != null) {
        _onPop[_stack.last] = lastRemovedCompleter;
      }

      _logger.debug(
        'removeUntil: stack after removing ${_stack.map((p) => p.name)}',
      );

      return true;
    }

    _logger.debug('removeUntil: could not find any match $screenIsAny}');
    return false;
  }

  /// Same behaviour as [removeUntil] plus calling setState on success
  void popUntil({required Set<String> screenIsAny}) {
    final success = removeUntil(screenIsAny: screenIsAny);

    if (success) {
      setState(() {});
    }
  }

  void pop<T extends Object>([T? value]) {
    final page = _stack.removeLast();
    final completer = _onPop.remove(page);
    if (completer != null) {
      completer.complete();
    }
    _logger.debug('pop: popped ${page.name} with value $value');
    setState(() {});
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final page = route.settings as Page;
    final index = _stack.indexOf(page);
    if (index != -1) {
      _stack.remove(page);
      final completer = _onPop.remove(page);
      if (completer != null) {
        completer.complete();
      }
      _logger.debug('onPopPage: popped ${page.name}');
    }
    setState(() {});
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState!.maybePop(),
      child: Navigator(
        key: _navigatorKey,
        pages: List.of(_stack),
        onPopPage: _onPopPage,
      ),
    );
  }
}
