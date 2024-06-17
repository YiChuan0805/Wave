import 'package:flutter/material.dart';
import 'package:anxietynomore/pop_fidget_toy.dart';
import 'package:anxietynomore/flash_card_grid.dart';
import 'package:confetti/confetti.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:anxietynomore/counter_screen.dart';
import 'dart:math';
import 'dart:async';

class FidgetPage extends StatefulWidget {
  @override
  _FidgetPageState createState() => _FidgetPageState();
}

class _FidgetPageState extends State<FidgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ConfettiController _confcontroller;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool isToggleOn = false;
  bool isSpacebarPressed = false;
  bool isLampOn = false;
  bool isPenClicked = false;
  bool isToggleAudio1 = true;
  double red = 0;
  double green = 0;
  double blue = 0;
  int diceNumber = 1;
  List<String> diceImages = [
    'assets/image/1.png',
    'assets/image/2.png',
    'assets/image/3.png',
    'assets/image/4.png',
    'assets/image/5.png',
    'assets/image/6.png',
  ];
  Timer? _diceTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _confcontroller = ConfettiController(duration: Duration(seconds: 1));
  }

  void _toggleToggle() {
    setState(() {
      isToggleOn = !isToggleOn;
      HapticFeedback.heavyImpact();
      _assetsAudioPlayer.open(
        Audio(isToggleAudio1 ? "assets/effects/switchon.mp3" : "assets/effects/switchoff.mp3"),
      );
      isToggleAudio1 = !isToggleAudio1;
    });
  }

  void _toggleSpacebar() {
    setState(() {
      isSpacebarPressed = true;
      HapticFeedback.heavyImpact();
      _assetsAudioPlayer.open(
        Audio("assets/effects/keyboard.mp3"),
      );
      print("clicky");
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
      HapticFeedback.heavyImpact();
      _assetsAudioPlayer.open(
        Audio(isToggleAudio1 ? "assets/effects/lighton.mp3" : "assets/effects/lightoff.mp3"),
      );
      isToggleAudio1 = !isToggleAudio1;
    });
  }

  void _rollDice() {
    _assetsAudioPlayer.open(
      Audio("assets/effects/dice.mp3"),
    );

    _diceTimer?.cancel(); // Cancel any previous timer
    _diceTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        diceNumber = Random().nextInt(6) + 1; // Generates a random number between 1 and 6
      });
    });

    Future.delayed(Duration(seconds: 1), () {
      _diceTimer?.cancel(); // Stop the timer after 1 second
      setState(() {
        diceNumber = Random().nextInt(6) + 1;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confcontroller.dispose();
    _diceTimer?.cancel(); // Ensure the timer is cancelled when the widget is disposed
    super.dispose();
  }

  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double buttonPadding = screenWidth * 0.02; // 2% of screen width

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.03), // 5% of screen width
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: screenHeight * 0.01), // 2% of screen height
                Text(
                  'Interact with fidgets to calm your anxiety',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.45, // 45% of screen width
                      height: screenHeight * 0.17, // 15% of screen height
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          value: isToggleOn,
                          onChanged: (newValue) {
                            _toggleToggle();
                            HapticFeedback.heavyImpact();
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleLamp,
                      child: Container(
                        width: screenWidth * 0.35, // 35% of screen width
                        height: screenHeight * 0.17, // 15% of screen height
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
                            size: screenHeight * 0.05, // 5% of screen height
                            color: isLampOn
                                ? Colors.yellow[800]
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                GestureDetector(
                  onTap: _toggleSpacebar,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    width: isSpacebarPressed
                        ? screenWidth * 0.88 // 88% of screen width
                        : screenWidth * 0.92, // 92% of screen width
                    height: isSpacebarPressed
                        ? screenHeight * 0.06 // 6% of screen height
                        : screenHeight * 0.07, // 7% of screen height
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
                          fontSize: screenWidth * 0.05, // 5% of screen width
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidth * 0.35, // 30% of screen width
                      height: screenHeight * 0.25, // 25% of screen height
                      child: RGBBox(Color.fromRGBO(
                          red.toInt(), green.toInt(), blue.toInt(), 1)),
                    ),
                    SizedBox(width: screenWidth * 0.05), // 5% of screen width
                    SizedBox(
                      width: screenWidth * 0.5, // 50% of screen width
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Slider(
                            thumbColor: Colors.red,
                            activeColor: Colors.red,
                            value: red,
                            min: 0,
                            max: 255,
                            onChanged: (value) {
                              setState(() {
                                red = value;
                                HapticFeedback.heavyImpact();
                              });
                            },
                          ),
                          Slider(
                            thumbColor: Colors.green,
                            activeColor: Colors.green,
                            value: green,
                            min: 0,
                            max: 255,
                            onChanged: (value) {
                              setState(() {
                                green = value;
                                HapticFeedback.heavyImpact();
                              });
                            },
                          ),
                          Slider(
                            thumbColor: Colors.blue,
                            activeColor: Colors.blue,
                            value: blue,
                            min: 0,
                            max: 255,
                            onChanged: (value) {
                              setState(() {
                                blue = value;
                                HapticFeedback.heavyImpact();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: _rollDice,
                      child: Container(
                        width: screenWidth * 0.45, // 55% of screen width
                        height: screenHeight * 0.2, // 20% of screen height
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                          child: Image.asset(
                            diceImages[diceNumber - 1], // Path to the dice image based on diceNumber
                            width: screenWidth * 0.8, // 80% of screen width
                            height: screenHeight * 0.8, // 80% of screen height
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              _confcontroller.play();
                              _assetsAudioPlayer.open(
                                Audio("assets/effects/party.mp3"),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                            child: Image.asset(
                              "assets/fidget/confetti_icon.png",
                              fit: BoxFit.contain,
                              width: screenWidth * 0.25, // 25% of screen width
                              height: screenHeight * 0.2, // 20% of screen height
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.1, // Adjust this value as needed
                          left: screenWidth * 0.125, // Adjust this value as needed
                          child: Align(
                            alignment: Alignment.center,
                            child: ConfettiWidget(
                              confettiController: _confcontroller,
                              blastDirectionality: BlastDirectionality.explosive,
                              maxBlastForce: 50,
                              minBlastForce: 30,
                              emissionFrequency: 0.0001,
                              numberOfParticles: 50,
                              maximumSize: Size(10.0, 10.0),
                              minimumSize: Size(5.0, 5.0),
                              gravity: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _navigateToPage(PopFidgetToy()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(buttonPadding),
                      ),
                      child: Image.asset(
                        "assets/fidget/popper_icon.png",
                        fit: BoxFit.contain,
                        width: screenWidth * 0.22, // 22% of screen width
                        height: screenHeight * 0.11, // 11% of screen height
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _navigateToPage(CounterScreen()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(buttonPadding),
                      ),
                      child: Image.asset(
                        "assets/fidget/tap_icon.png",
                        fit: BoxFit.contain,
                        width: screenWidth * 0.22, // 22% of screen width
                        height: screenHeight * 0.11, // 11% of screen height
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _navigateToPage(FlashCardPage()),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(buttonPadding),
                      ),
                      child: Image.asset(
                        "assets/fidget/flash_icon.png",
                        fit: BoxFit.contain,
                        width: screenWidth * 0.22, // 22% of screen width
                        height: screenHeight * 0.11, // 11% of screen height
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RGBBox extends StatelessWidget {
  final Color color;

  RGBBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }
}
