import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/winkwell.dart';

class OnBoardingPageSecond extends StatelessWidget {
  const OnBoardingPageSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); //TODO jump na posledni stranku
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Přeskočit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  'Kdy ses narodil/a?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Container(
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: WInkWell(
                    onTap: () {},
                    materialColor: const Color(0xFFEFAD89),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: const SizedBox(
                      height: 65,
                      child: Align(
                        child: Text('Pokračovat',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
