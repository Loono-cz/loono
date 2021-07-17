import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/indicator.dart';
import 'package:loono/ui/widgets/indicator_row.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            children: const <Widget>[
              Center(
                child: Text('First Page'),
              ),
              Center(
                child: Text('Second Page'),
              ),
              Center(
                child: Text('Third Page'),
              ),
              Center(
                child: Text('Fourth Page'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 21.0, right: 21.0),
            child: IndicatorRow(
              currentIndex: pageController.hasClients
                  ? pageController.page?.toInt() ?? 0
                  : 0,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPageView extends StatefulWidget {
  const CustomPageView({Key? key}) : super(key: key);

  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: const <Widget>[
          Center(
            child: Text('First Page'),
          ),
          Center(
            child: Text('Second Page'),
          ),
          Center(
            child: Text('Third Page'),
          ),
        ],
      ),
    );
  }
}
