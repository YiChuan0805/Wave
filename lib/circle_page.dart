import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  String currentImage = 'assets/breathe/moon.png'; // initial image

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    animation = Tween<double>(begin: 200, end: 400).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 21, 21, 21), // dark grey color
                  ),
                  onPressed: () {
                    setState(() {
                      currentImage = 'assets/breathe/moon.png';
                    });
                  },
                  child: Image.asset('assets/breathe/moon.png', height: 50,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 21, 21, 21), // dark grey color
                  ),
                  onPressed: () {
                    setState(() {
                      currentImage = 'assets/breathe/moon.png';
                    });
                  },
                  child: Image.asset('assets/breathe/moon.png', height: 50,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 21, 21, 21), // dark grey color
                  ),
                  onPressed: () {
                    setState(() {
                      currentImage = 'assets/breathe/sun.png';
                    });
                  },
                  child: Image.asset('assets/breathe/sun.png', height: 50,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 21, 21, 21), // dark grey color
                  ),
                  onPressed: () {
                    setState(() {
                      currentImage = 'assets/breathe/yy.png';
                    });
                  },
                  child: Image.asset('assets/breathe/yy.png', height: 50,),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onLongPress: () {
              controller.forward();
            },
            onLongPressEnd: (details) {
              controller.reverse();
            },
            child: Center(
              child: SizedBox(
                width: animation.value,
                height: animation.value,
                child: Image.asset(currentImage, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
