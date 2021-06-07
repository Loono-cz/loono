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
  const ScreenNavigator({required this.initialPages, Key? key})
      : super(key: key);

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
    _logger
      ..debug('pushAsync: pushing ${page.name}')
      ..debug('pushAsync: expecting a value of type $T');
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
    _onPop.remove(removedPage);
    _logger.debug('pushReplacement: removed ${removedPage.name}');

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

    for (final page in _stack.reversed) {
      if (screenIsAny.contains(page.name)) {
        break;
      } else {
        updatedStack.remove(page);
        updatedOnPop.remove(page);
      }
    }

    if (updatedStack.isNotEmpty) {
      _logger.debug(
        'removeUntil: stack before removing ${_stack.map((p) => p.name)}',
      );
      _stack
        ..clear()
        ..addAll(updatedStack);
      _onPop
        ..clear()
        ..addAll(updatedOnPop);
      _logger.debug(
        'removeUntil: stack after removing ${_stack.map((p) => p.name)}',
      );
      return true;
    }

    _logger.debug(
      'removeUntil: could not find any screen matching $screenIsAny}',
    );
    return false;
  }

  /// Same behaviour as [removeUntil] plus calling setState
  /// to update the widget tree on success
  void popUntil({required Set<String> screenIsAny}) {
    final success = removeUntil(screenIsAny: screenIsAny);

    if (success) {
      setState(() {});
    }
  }

  void pop() {
    final page = _stack.removeLast();
    final completer = _onPop.remove(page);
    if (completer != null) {
      completer.complete();
    }
    _logger.debug('pop: popped ${page.name}');
    setState(() {});
  }

  void popWith<T>([T? value]) {
    if (_onPop.containsKey(_stack.last)) {
      final page = _stack.removeLast();
      final completer = _onPop.remove(page);
      if (completer != null) {
        completer.complete(value);
      }
      _logger
        ..debug('popWith: popped ${page.name}')
        ..debug('popWith: returning $value');
      setState(() {});
    } else {
      throw 'To return a value from a screen use the [pushAsync] method';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigatorKey.currentState!.maybePop(),
      child: Navigator(
        key: _navigatorKey,
        pages: List.of(_stack),
        onPopPage: (route, dynamic result) {
          final page = route.settings as Page;
          final index = _stack.indexOf(page);
          if (index != -1) {
            _stack.remove(page);
            _onPop.remove(page);
            final completer = _onPop.remove(page);
            if (completer != null) {
              completer.complete();
            }
            _logger.debug('onPopPage: popped ${page.name}');
          }
          setState(() {});
          return route.didPop(result);
        },
      ),
    );
  }
}
