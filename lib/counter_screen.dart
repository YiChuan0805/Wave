import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:anxietynomore/contacts_page.dart';
import 'package:anxietynomore/music_page.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  int _goal = 10;
  Color _currColor = Colors.white;

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

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == _goal) {
        // Change background color to a random bright color
        _changeBackgroundColor();
        // Increase the goal by 10
        _goal += 10;
      }
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
        title: const Text('Anxiety No More'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.contacts), // choose an appropriate icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.music_note), // choose an appropriate icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MusicPage()),
              );
            },
          ),
        ],
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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