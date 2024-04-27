import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    animation = Tween<double>(begin: 100, end: 150).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        controller.forward();
      },
      onLongPressEnd: (details) {
        controller.reverse();
      },
      child: Center(
        child: SizedBox(
          width: animation.value,
          height: animation.value,
          child: Image.asset('sun.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
