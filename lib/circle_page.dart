import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  late Animation<double> sizeAnimation;
  late Animation<double> rotationAnimation;
  late AnimationController controller;
  String currentImage = 'assets/breathe/purple.png'; // initial image
  String instructionText = 'Press the circle and Inhale'; // initial instruction text
  int progress = 0; // progress tracker
  int currentGroup = 0; // current animation group count
  int maxGroups = 10; // total number of animation groups
  double initialSize = 200.0; // initial size of the circle

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    sizeAnimation = Tween<double>(begin: initialSize, end: 400).animate(controller)
      ..addListener(() {
        setState(() {});
        HapticFeedback.heavyImpact();
      });

    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    sizeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          instructionText = 'Release the circle and Exhale';
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          instructionText = 'Press the circle and Inhale';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(95, 37, 37, 37),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInformationBottomSheet(context);
        },
        child: Icon(Icons.info, color: Colors.white),
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCircleButton('assets/breathe/purple.png'),
                _buildCircleButton('assets/breathe/moon.png'),
                _buildCircleButton('assets/breathe/sun.png'),
                _buildCircleButton('assets/breathe/yy.png'),
              ],
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${currentGroup}/$maxGroups',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Text(
                instructionText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: 300,
            height: 10,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: (progress / maxGroups) * 300,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    10,
                    (index) => Container(
                      width: 29.5,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GestureDetector(
              onTapDown: (_) {
                _startAnimation();
              },
              onTapUp: (_) {
                _stopAnimation();
              },
              child: Center(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationAnimation.value * 3.14, // Rotate from 0 to 180 degrees
                      child: SizedBox(
                        width: sizeAnimation.value,
                        height: sizeAnimation.value,
                        child: Image.asset(currentImage, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startAnimation() {
    HapticFeedback.heavyImpact(); // Vibrate on tap down
    controller.forward();
  }

  void _stopAnimation() {
    controller.reverse();
    if (sizeAnimation.value >= 400.0) {
      setState(() {
        progress += 1; // Increase progress by 1 for each completed group
        currentGroup++; // Increment current group count
        if (currentGroup >= maxGroups) {
          // Reset after completing all groups
          currentGroup = 0;
          progress = 0;
          // Show completion dialog after completing all groups
          _showCompletionDialog();
        }
      });
    }
  }

  Widget _buildCircleButton(String imagePath) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            currentImage = imagePath;
          });
        },
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: 40,
          height: 40,
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          backgroundColor: const Color.fromARGB(255, 65, 65, 65),
          padding: EdgeInsets.all(20), // dark grey color
        ),
      ),
    );
  }

  void _showInformationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.grey[900],
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome to Breathe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Choose your favorite icon and follow the guided breathing exercise to calm down.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 37, 37, 37),
          title: Text(
            "Breathe Exercise Completed",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Inter',
            ),
          ),
          content: Text(
            "Congratulation! You have completed 10 cycles. Do you want to continue?",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Additional logic if user does not want to continue
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Additional logic if user wants to continue
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
