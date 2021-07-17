import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/indicator.dart';
import 'package:loono/ui/widgets/indicator_row.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {});
            },
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
                  ? pageController.page?.round() ?? 0
                  : 0,
            ),
          ),
        ],
      ),
    );
  }
}
