import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FidgetPage extends StatefulWidget {
  @override
  _FidgetPageState createState() => _FidgetPageState();
}

class _FidgetPageState extends State<FidgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isToggleOn = false;
  bool isSpacebarPressed = false;
  bool isLampOn = false;
  bool isPenClicked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void _toggleToggle() {
    setState(() {
      isToggleOn = !isToggleOn;
    });
  }

  void _toggleSpacebar() {
    setState(() {
      isSpacebarPressed = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        isSpacebarPressed = false;
      });
    });
  }

  void _toggleLamp() {
    setState(() {
      isLampOn = !isLampOn;
    });
  }

  void _togglePenClick() {
    setState(() {
      isPenClicked = !isPenClicked;
      if (isPenClicked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fidget App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Toggle Button
            Switch(
              value: isToggleOn,
              onChanged: (newValue) {
                _toggleToggle();
              },
            ),
            SizedBox(height: 20),
            // Custom Spacebar Key
            GestureDetector(
              onTap: _toggleSpacebar,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: isSpacebarPressed ? 80 : 100,
                height: isSpacebarPressed ? 40 : 50,
                decoration: BoxDecoration(
                  color: isSpacebarPressed ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'SPACE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Lamp
            GestureDetector(
              onTap: _toggleLamp,
              child: Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  color: isLampOn ? Colors.yellow[200] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isLampOn ? Icons.lightbulb : Icons.lightbulb_outline,
                    size: 48,
                    color: isLampOn ? Colors.yellow[800] : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Clicking Pen
            GestureDetector(
              onTap: _togglePenClick,
              child: Container(
                width: 100,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                    child: Icon(
                      Icons.edit,
                      size: 48,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
