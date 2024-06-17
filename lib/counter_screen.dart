import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  int _goal = 10;
  Color _currColor = Colors.white;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  final List<Color> _brightColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.amber,
  ];
  late ConfettiController _confettiController; // 步骤 1：创建 ConfettiController 实例

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 1)); // 步骤 2：初始化 ConfettiController
  }

  @override
  void dispose() {
    _confettiController.dispose(); // 步骤 3：释放 ConfettiController
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == _goal) {
        // Change background color to a random bright color
        _changeBackgroundColor();
        // Increase the goal by 10
        _goal += 10;
        _confettiController.play(); // 步骤 4：播放 Confetti 动画
      }
      _assetsAudioPlayer.open(
        Audio("assets/effects/tap.mp3"),
      );
      HapticFeedback.heavyImpact();
    });
  }

  void _changeBackgroundColor() {
    final random = Random();
    _currColor = _brightColors[random.nextInt(_brightColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _incrementCounter,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Number Tap',
            style: TextStyle(
              color: Colors.white, // Set title text color to white
              fontSize: 30, // Set font size to 30
              fontFamily: 'Inter', // Set font family to Inter
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(95, 37, 37, 37), // Set app bar color to black
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.5), // Set the height of the bottom widget
            child: Container(
              height: 1.0,
              color: Colors.white, // Set color to white
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Set back button color to white
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Color.fromARGB(95, 70, 70, 70),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 50,
                minBlastForce: 30,
                emissionFrequency: 0.1,
                numberOfParticles: 50,
                maximumSize: Size(10.0, 10.0),
                minimumSize: Size(5.0, 5.0),
                gravity: 1,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _currColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '$_counter',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Goal: $_goal',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
